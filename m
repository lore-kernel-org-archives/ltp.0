Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1VhDjk-0003Ty-6y
	for ltp-list@lists.sourceforge.net; Fri, 15 Nov 2013 07:22:40 +0000
Received: from mail-pb0-f52.google.com ([209.85.160.52])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VhDjg-0000sx-Al
	for ltp-list@lists.sourceforge.net; Fri, 15 Nov 2013 07:22:40 +0000
Received: by mail-pb0-f52.google.com with SMTP id wy17so2000210pbc.25
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Nov 2013 23:22:28 -0800 (PST)
Message-ID: <5285BEE3.5030405@casparzhang.com>
Date: Fri, 15 Nov 2013 14:27:47 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
	<1384400319-30776-7-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1384400319-30776-7-git-send-email-vincent.hsu@linaro.org>
Subject: Re: [LTP] [LNG][PATCH 7/8] ltp-networking/tcp_cmds/netstat: fix
 netstat test
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
To: Vincent Hsu <vincent.hsu@linaro.org>, ltp-list@lists.sourceforge.net
Cc: linaro-networking@linaro.org

On 11/14/2013 11:38 AM, Vincent Hsu wrote:
> The netstat command will return nozero on Ubuntu 12.04 even if
> execution success.
>
> for example:
> in Ubuntu
>      $ netstat -s 1>/dev/null 2>&1 ; echo $?
>      1
> in CentOS
>      $ netstat -s 1>/dev/null 2>&1 ; echo $?
>      0
>
> Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>

This should be a bug in netstat @ Ubuntu I guess?

Caspar

> ---
>   testcases/network/tcp_cmds/netstat/netstat01 |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/network/tcp_cmds/netstat/netstat01 b/testcases/network/tcp_cmds/netstat/netstat01
> index 3c2d1bb..6d4682a 100755
> --- a/testcases/network/tcp_cmds/netstat/netstat01
> +++ b/testcases/network/tcp_cmds/netstat/netstat01
> @@ -58,7 +58,8 @@ do_test() {
>       while [ $TST_COUNT -le $NUMLOOPS ]; do
>
>           for flag in "-s" "-rn" "-i" "-gn" "-apn"; do
> -            if ! netstat $flag 1>/dev/null 2>&1; then
> +            var=$(netstat $flag 1>/dev/null 2>&1);
> +            if [ "$var" != "" ]; then
>                   end_testcase "netstat $flag failed"
>               fi
>           done
> --
> 1.7.9.5
>
>
> ------------------------------------------------------------------------------
> DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
> OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
> Free app hosting. Or install the open source package on any LAMP server.
> Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
> http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
