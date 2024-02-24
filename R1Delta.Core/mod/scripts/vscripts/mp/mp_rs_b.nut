
function main()
{
	if ( reloadingScripts )
		return

	GM_AddEndRoundFunc( EndRoundMain )
}

function EntitiesDidLoad()
{
	//if ( EvacEnabled() )
	//	EvacSetup()

	RegisterSignal( "ChangeSpawnPoint" )

	thread ChangeSpawnPoint()
}

function EvacSetup()
{
    PrintFunc()
	local spectatorNode1 = GetEnt( "spec_cam1" )
	local spectatorNode2 = GetEnt( "spec_cam2" )
	local spectatorNode3 = GetEnt( "spec_cam3" )

	Evac_AddLocation( "escape_node1", spectatorNode1.GetOrigin(), spectatorNode1.GetAngles() )
	Evac_AddLocation( "escape_node2", spectatorNode2.GetOrigin(), spectatorNode2.GetAngles() )
	Evac_AddLocation( "escape_node3", spectatorNode3.GetOrigin(), spectatorNode3.GetAngles() )

	local spacenode = GetEnt( "intro_SpaceNode" )

	Evac_SetSpaceNode( spacenode )
	Evac_SetupDefaultVDUs()
}

function EndRoundMain()
{
	if ( EvacEnabled() )
		GM_SetObserverFunc( EvacObserverFunc )
}

function EvacObserverFunc( player )
{
	player.SetObserverModeStaticPosition( level.ExtractLocations[ level.SelectedExtractLocationIndex ].spectatorPos )
	player.SetObserverModeStaticAngles( level.ExtractLocations[ level.SelectedExtractLocationIndex ].spectatorAng )

	player.StartObserverMode( OBS_MODE_CHASE )
	player.SetObserverTarget( null )
}

// [LJS] titan rush. 조건에 따라 스폰포인트 이동.
function ChangeSpawnPoint()
{
	/*
	enum eTitanRushSpawnCase
	{
		NORMAL,
		HACKED_A,
		HACKED_B,
		HACKED_A_B,
		DESTROY_A,
		DESTROY_B,
	}
	*/

	for(;;)
	{
		local result = WaitSignal( level.ent, "ChangeSpawnPoint" )

		printt( "[LJS]ChangeSpawnPoint result: ", result.spawnCase )

		// 조건에 따라 스폰포인트 이동
		switch ( result.spawnCase )
		{
			// 기본
			case eTitanRushSpawnCase.NORMAL: 
				//MoveEntity( "info_spawnpoint_human_1",	Vector( -4754.31, 530.761, 425 ),	Vector( 0, 0.0, 0 )	)
			break

			// A 지점 해킹
			case eTitanRushSpawnCase.HACKED_A: 
			break

			// B 지점 해킹
			case eTitanRushSpawnCase.HACKED_B: 
			break

			// A, B 지점 해킹
			case eTitanRushSpawnCase.HACKED_A_B: 
			break

			// A 지점 파괴
			case eTitanRushSpawnCase.DESTROY_A: 
			break

			// B 지점 파괴
			case eTitanRushSpawnCase.DESTROY_B: 
			break
		}
	}
}

main()