Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwYNF-0008I5-9f
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 13:54:33 +0000
Date: Tue, 9 Jul 2013 15:56:09 +0200
From: chrubis@suse.cz
Message-ID: <20130709135609.GF30721@rei>
References: <1C23526A7C42DB45BBF55B662C7C530E25B424AA42@BUNGLE.Emea.Arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1C23526A7C42DB45BBF55B662C7C530E25B424AA42@BUNGLE.Emea.Arm.com>
Subject: Re: [LTP] [PATCH] flock03.c: fixes a typo when compiling with
 UCLINUX=1
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
To: Benoit Marcot <Benoit.Marcot@arm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> flock03.c: This patch fixes a typo when compiling with UCLINUX=1.
> 
> Corrects FILENAME to FILE_NAME, and removes some trailing white-spaces in
> empty lines.
> 
> Signed-off-by: Benoit Marcot <benoit.marcot@arm.com>

Still not right :(

Now the git am complains about corrupted patch and indeed the line in
question looks like:

                if (pid =3D=3D -1)

Looks like the mail was converted to quoted-printable including the
patch itself.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
