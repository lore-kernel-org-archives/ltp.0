From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Apr 2020 15:06:22 +0200
Subject: [LTP] [PATCH 1/1] net/sendfile01.sh: Check with timeout
In-Reply-To: <20200424125349.GA31142@dell5510>
References: <20200421180002.11351-1-pvorel@suse.cz>
 <dab04fc5-5d20-3dbc-c21f-535112ab222f@oracle.com>
 <20200424125349.GA31142@dell5510>
Message-ID: <20200424130622.GA1656@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> > > What bothers me more, that TST_NEEDS_CMDS does not check command on
> > > rhost. Do we want to have something like TST_NEEDS_CMDS_RHOST or we just
> > > don't care?

> > In general, yes, we need to check if a command exists on the remote host.
> > Yet another variable, what about checking what in TST_NEEDS_CMDS on the
> > remote host? Though TST_NEEDS_CMDS_RHOST looks quite well.

> Hm, looking on the implementation. tst_require_cmds() and tst_cmd_available()
> are functions, thus not runnable with tst_rhost_run(). We can add this code to
> custom shell script which checks or C code (shell has dependencies). Or any
> other idea?

BTW normally it works to load script and then run function.
$ cat foo.sh
#!/bin/sh
foo() { echo "foo: $$"; }

$ sh -c ". foo.sh; foo"
foo: 32479

But this somehow doesn't work for tst_net.sh:

diff --git testcases/lib/tst_net.sh testcases/lib/tst_net.sh
index 1ec03c738..728987f0b 100644
--- testcases/lib/tst_net.sh
+++ testcases/lib/tst_net.sh
@@ -57,6 +57,7 @@ tst_net_remote_tmpdir()
 
 tst_net_setup()
 {
+	tst_rhost_run -c ". tst_net.sh; tst_require_cmds $TST_NEEDS_CMDS"
 	tst_net_remote_tmpdir
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 

results in:
/opt/ltp/testcases/bin/tst_net.sh: line 944: tst_cmd_available: command not found

tst_cmd_available() is needed for the end of tst_net.sh:
if [ -z "$TST_USE_LEGACY_API" ] && ! tst_cmd_available ping6; then
	ping6()
	{
		ping -6 $@
	}
	if [ -z "$_tst_net_ping6_warn_printed" ]; then
		tst_res_ TINFO "ping6 binary/symlink is missing, using workaround. Please, report missing ping6 to your distribution."
		export _tst_net_ping6_warn_printed=1
	fi
fi

=> sourcing of shell scripts with "." does not work on 'sh -c'.

Kind regards,
Petr
