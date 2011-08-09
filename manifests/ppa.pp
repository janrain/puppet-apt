# ppa.pp

define apt::ppa(

) {
    require apt

    exec { "apt-update-${name}":
        command     => "/usr/bin/aptitude update",
        refreshonly => true,
    }

    exec { "add-apt-repository-${name}":
        command => "/usr/bin/add-apt-repository ${name}",
        onlyif => "! test -f /etc/apt/sources.list.d/nagiosinc-ppa-$lsbdistcodename.list",
        notify  => Exec["apt-update-${name}"],
    }
}

