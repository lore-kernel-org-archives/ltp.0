From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Apr 2018 15:18:52 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Add test cmd helper
 tst_test_cmds()
In-Reply-To: <20180406070844.dbbedq7c4qso25ct@dell5510>
References: <20180406064204.9252-1-pvorel@suse.cz>
 <20180406070844.dbbedq7c4qso25ct@dell5510>
Message-ID: <20180409131852.GD26048@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +		which $1 > /dev/null 2>&1 || return 1
> Pedantic version would check $? for 127 (indicating which itself it's not found).
> Probably worth of adding it.

Are you sure?

$ which foo
...
$ echo $?
1

Also:

$ busybox which foo
$ echo $?
1


-- 
Cyril Hrubis
chrubis@suse.cz
