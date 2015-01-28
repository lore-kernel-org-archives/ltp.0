Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YGHHc-0008Mh-2r
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 01:19:04 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGHHZ-0007NI-Hs
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 01:19:04 +0000
Message-ID: <1422407877.13104.12.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 28 Jan 2015 09:17:57 +0800
In-Reply-To: <54C7BA88.6060103@oracle.com>
References: <54B7D920.7050402@oracle.com>
	<1421818093-24202-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1421818093-24202-2-git-send-email-zenglg.jy@cn.fujitsu.com>
	<54C22A1A.2050906@oracle.com>
	<1422344483.1619.52.camel@G08JYZSD130126.localdomain>
	<54C7BA88.6060103@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2 2/3] telnet: Cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
On Tue, 2015-01-27 at 19:19 +0300, Alexey Kodanev wrote:
> Hi!
> On 01/27/2015 10:41 AM, Zeng Linggang wrote:
> > Hi!
> > On Fri, 2015-01-23 at 14:01 +0300, Alexey Kodanev wrote:
> >> Hi!
> >> On 21.01.2015 8:28, Zeng Linggang wrote:
> >>> * Add 'TCID' and 'TST_TOTAL'.
> >>> * Use 'test.sh'.
> >>> * Delete some useless comment.
> >>> * Some cleanup.
> >>>
> >>> Signed-off-by: Zeng Linggang<zenglg.jy@cn.fujitsu.com>
> >>> ---
> >>> -} else {
> >>> -   set LOOPCOUNT 25
> >>> +	if [ -z $LOOPCOUNT ]; then
> >>> +		LOOTCOUNT=25
> >>                                              ^
> >>                                              should be 'P' here
> >>
> > What is the 'P' mean?
> 
> sorry, pointed to the wrong (empty) place... "LOOPCOUNT=25", not 
> "LOOTCOUNT=25"
> 

Yep. Thank you very much.

> >>> +	fi
> >>>    }
> >>>    
> >>> -# stty echo
> >>> -send_user " Starting\n"
> >>> -
> >>> -# Do foreach host on command line
> >>> -set count 0
> >>> -while {$count < $LOOPCOUNT} {
> >>> -   set count [expr $count+1]
> >>> -   foreach HOST $RHOST {
> >>> -      send_user "Host: $HOST\n"
> >>> -
> >>> -      # telnet to the host
> >>> -      spawn telnet $HOST
> >>> -      expect -re "login:"
> >>> -
> >>> -      send "$RUSER\r"
> >>> -      expect -re "Password:"
> >>> +do_test()
> >>> +{
> >>> +	tst_resm TINFO "Starting"
> >>>    
> >>> -      send "$PASSWD\r"
> >>> -
> >>> -      send "PS1=\"$PROMPT\"\r"
> >>> -      # Wait for shell prompt
> >>> -      expect "$PROMPT"
> >>> +	for i in $(seq 1 ${LOOPCOUNT})
> >>> +	do
> >>> +		telnet_test || return 1
> >>> +	done
> >>> +}
> >>>    
> >>> -      # Run passwd command - and respond to its prompts
> >>> -      send "LC_ALL=C ls -l /etc/hosts | wc -w > $TESTLOG/$RUSER.$HOST \r"
> >>> -      # When shell prompt comes back, logout
> >>> +telnet_test()
> >>> +{
> >>> +	expect -c "
> >>> +		spawn telnet $RHOST
> >>> +		expect -re \"login:\"
> >>> +		send \"$RUSER\r\"
> >>> +		expect -re \"Password:\"
> >>> +		send \"$PASSWD\r\"
> >>> +
> >>> +		send \"LC_ALL=C ls -l /etc/hosts | wc -w > $RUSER.$RHOST \r\"
> >>> +		expect \"$RUSER@\"
> >> This part needs some extra checking for failed login, e.g. 'incorrect'
> >> password or connection timeout:
> >>
> >> expect -re "incorrect" {
> >>       exit 1
> >> } -re "$USERS@"
> >>
> >>
> > Good idea. Thanks.
> >
> >>> +		exp_send \"logout\r\"
> >>> +
> >> The below part can be changed to:
> >>           tst_resm TINFO "checking telnet status"
> >>           tst_rhost_run -s -c "grep -q 9 $RUSER.$RHOST"
> >>           tst_rhost_run -c "rm -f $RUSER.$RHOST"
> >>
> >> Note, 'tst_rhost_run' with '-s' option should exit with TBROK if remote
> >> command returns non-zero exit status, please find the following patch
> >> with the fix:
> >>
> >> [PATCH v2] lib/test_net.sh: fix 'tst_rhost_run -s' when errors occur.
> >>
> > Thank you. I have found the patch.
> >
> >>> +		send_user \"CHECKING TELNET STATUS\n\"
> >>> +
> >>> +		set nummatch [exec rsh -n -l $RUSER $RHOST \\
> >>> +			      \"grep -c 9 $RUSER.$RHOST\"]
> >>> +		if {\$nummatch==1} {
> >>> +			exec rsh -n -l $RUSER $RHOST \"rm -f $RUSER.$RHOST\"
> >>> +		} else {
> >>> +			exit 1
> >>> +		}
> >>> +	"
> >>> +}
> >>>    
> >>> -      expect "$PROMPT"
> >>> -      exp_send "logout\r"
> >>> +setup
> >>>    
> >>> -      send_user "CHECKING TELNET STATUS\n"
> >>> -      set nummatch [exec rsh -n -l $RUSER $HOST "cat $TESTLOG/$RUSER.$HOST|grep -c 9"]
> >>> -      if {$nummatch==1} {
> >>> -         send_user "$TC interactive Test Successful in LOOP $count\r"
> >>> -         exec rsh -n -l $RUSER $HOST "rm -f $TESTLOG/$RUSER.$HOST"
> >>> -      } else {
> >>> -         send_user "$TC interactive session failed\n"
> >>> -         exit 1
> >>> -      }
> >>> -   }
> >>> -}
> >>> +do_test
> >>> +if [ $? -ne 0 ]; then
> >>> +	tst_resm TFAIL "Test $TCID failed."
> >>> +else
> >>> +	tst_resm TPASS "Test $TCID successed."
> >> "'succeeded"
> >>
> > Yep.
> >
> >>> +fi
> >>>    
> >>> -send_user "\nTest PASSES\n\n"
> >>> -exit 0
> >>> +tst_exit
> >> Also, there is too much non-standard LTP output, especially if LOOPCOUNT
> >> is big. Could we send it to a file and only if there are some errors,
> >> print it. Any thoughts?
> >>
> > It is not bad, but we could not sure whether the test is being run when
> > we wait.
> 
> For example, it could be the below messages on each step or something 
> more informative.
> 
> tst_resm TINFO "login with telnet, step $i"
> 
> expect ...
> 
> tst_resm TINFO "checking telnet status"
> ...
> 

That's OK.

Best regards,
Zeng

> Best regards,
> Alexey



------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
