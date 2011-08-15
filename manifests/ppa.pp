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
        onlyif => "grep -q `echo ${name} | sed 's;\(.*:\)\(.*\);\2;g'` /etc/apt/sources.list.d/*.list",
        notify  => Exec["apt-update-${name}"],
    }
}

