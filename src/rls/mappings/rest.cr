module RLS::REST
  struct BatchPlayersPayload
    JSON.mapping(
      id: {type: String, key: "uniqueId"},
      platform: {type: Platform, key: "platformId", converter: PlatformConverter}
    )

    def initialize(@id : String, @platform : Platform = Platform::Steam)
    end
  end

  struct PlatformResponse
    JSON.mapping(
      id: UInt8,
      name: String
    )
  end

  # A Rocket League playlist with participation statistics
  struct PlaylistResponse
    JSON.mapping(
      id: UInt8,
      name: String,
      platform: {type: Platform, key: "platformId"},
      population: Population
    )

    delegate players, updated_at, to: population
  end

  # Participation statistics about a particular `Playlist`
  struct Population
    JSON.mapping(
      players: UInt32,
      updated_at: {type: Time, key: "updatedAt", converter: EpochConverter}
    )
  end

  # A ranked tier in Rocket League
  struct TierResponse
    JSON.mapping(
      id: {type: UInt8, key: "tierId"},
      name: {type: String, key: "tierName"}
    )
  end

  # Stat types to sort by in `REST#leaderboard`
  enum StatType : UInt8
    Wins
    Goals
    Mvps
    Saves
    Shots
    Assists
  end

  # Exclusively ranked playlists for use in `REST#leaderboard`
  enum RankedPlaylist : UInt8
    Duel         = 10
    Doubles      = 11
    SoloStandard = 12
    Standard     = 13
  end
end
