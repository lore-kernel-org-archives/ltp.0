From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 17:07:35 +0100
Subject: [LTP] Failing Fedora rawhide (again)
Message-ID: <20201113160735.GA8018@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this time it's on autoconf broken:

    /usr/bin/autoconf: This script requires a shell more modern than all
    /usr/bin/autoconf: the shells that I found on your system.
    /usr/bin/autoconf: Please tell bug-autoconf@gnu.org about your system,
    /usr/bin/autoconf: including any error possibly output before this
    /usr/bin/autoconf: message. Then install a modern shell, or manually run
    /usr/bin/autoconf: the script under such a shell if you do have one.

I suspect this is just for docker image (I remember some discussion on github,
but cannot find anything at [1] now).

I checked autoconf file and it's perfectly ok, thus I'll downgrade to Fedora
latest (33). I like rawhide for newest software (together with Tumbleweed),
but it must be working.

Kind regards,
Petr

[1] https://github.com/fedora-cloud/docker-brew-fedora/issues
