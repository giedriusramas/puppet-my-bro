service { 'wassup_bro':
    ensure  => $bro_state,
    status  => $status,
    start   => $start,
    restart => $restart,
    stop    => $stop,
    path    => "$basedir/bin/",
    require => File["$basedir/bin/wassup_bro"],
  }

