Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UNiwS-0005Va-Bp
	for ltp-list@lists.sourceforge.net; Thu, 04 Apr 2013 12:06:56 +0000
Date: Thu, 4 Apr 2013 14:07:38 +0200
From: chrubis@suse.cz
Message-ID: <20130404120738.GB7321@rei.suse.cz>
References: <1365038982.96284.YahooMailClassic@web120802.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1365038982.96284.YahooMailClassic@web120802.mail.ne1.yahoo.com>
Subject: Re: [LTP] ltp network multicast test cases
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
To: C Nandi <ccnandi@yahoo.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> ?????????????? /* Control parameters for ECHO replies. */?????????????? net->ipv4.sysctl_icmp_echo_ignore_all = 0;?????????????? net->ipv4.sysctl_icmp_echo_ignore_broadcasts = 1;??In ???mc_cmds??? test case we have code as below:???? ??cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1 > /dev/null???? if [ $? -eq 0 ]???? then???????????? end_testcase "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"???? fiHence the test tcase will fail always as icmp_echo_ignore_broadcasts is set to 1(which is default).??Can we go with below patch for this problem???--- mc_cmds.Orig?????????????? 2013-04-03 14:36:14.000000000 -0600+++ mc_cmds???????? 2013-04-03 14:39:02.000000000 -0600@@ -128,6 +128,9 @@?????? if [ $? -eq 0 ]?????? then?????????????? end_testcase "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"+???????????? echo "Temporarily enable multicast ping for testing
>  purposes."+???????????? echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts+???????????? icmp_need_reset=1?????? fi???????? # Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper@@ -166,6 +169,10 @@ {?????? $trace_logic?????? echo "$this_file: doing $0."+???? if [ -n "$icmp_need_reset" ]; then+???????????? echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts+???????????? echo "Restored multicast ping setting."+???? fi?????? rm -rf $PING_OUT }??

Looks like the email was mangled, most likely by your mail client.

> --- mc_cmds.Orig        2013-04-03 14:36:14.000000000 -0600
> +++ mc_cmds     2013-04-03 14:39:02.000000000 -0600
> @@ -128,6 +128,9 @@
>     if [ $? -eq 0 ]
>     then
>         end_testcase "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
> +       echo "Temporarily enable multicast ping for testing purposes."
> +       echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
> +       icmp_need_reset=1
>     fi
> 
>     # Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper
> @@ -166,6 +169,10 @@
>  {
>     $trace_logic
>     echo "$this_file: doing $0."
> +   if [ -n "$icmp_need_reset" ]; then
> +       echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
> +       echo "Restored multicast ping setting."
> +   fi
>     rm -rf $PING_OUT
>  }

Could you send these as signed patches in unified diff format with the
description of the changes in the patch header?

(git can help you create these)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
