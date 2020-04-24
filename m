From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Apr 2020 14:53:49 +0200
Subject: [LTP] [PATCH 1/1] net/sendfile01.sh: Check with timeout
In-Reply-To: <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
References: <20200421180002.11351-1-pvorel@suse.cz>
 <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
Message-ID: <20200424125349.GA31142@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> > What bothers me more, that TST_NEEDS_CMDS does not check command on
> > rhost. Do we want to have something like TST_NEEDS_CMDS_RHOST or we just
> > don't care?

> In general, yes, we need to check if a command exists on the remote host.
> Yet another variable, what about checking what in TST_NEEDS_CMDS on the
> remote host? Though TST_NEEDS_CMDS_RHOST looks quite well.

Hm, looking on the implementation. tst_require_cmds() and tst_cmd_available()
are functions, thus not runnable with tst_rhost_run(). We can add this code to
custom shell script which checks or C code (shell has dependencies). Or any
other idea?

Kind regards,
Petr
