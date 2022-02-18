Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B173CC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 12:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7205F3CA101
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 13:30:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D4C63C9375
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 13:30:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B1962013D9
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 13:30:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9741B210FC;
 Fri, 18 Feb 2022 12:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645187423;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1KSKetXYhqlZMq9F8sVumyGHBYH3i+7Ym2ZBZaH07c=;
 b=xkT7OLuacyE/VO345GEXdPV1Qt+V/hWg52c33fpY5F3H6phJUyTEkdak3868Mf0safYViw
 ojKSiHjqBlF6fN7WBlId3kOfjezI+LMUUcZsmi/grFpY/f39LZ3W59xHYcLDYNCn1VLJf5
 9EqQSrCsG/xZuM8C9Ck+6j4a57m7IWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645187423;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1KSKetXYhqlZMq9F8sVumyGHBYH3i+7Ym2ZBZaH07c=;
 b=VKtwWLfuHHF+YQepmeGifTRFgwV56ZL2SL0/Ma3OoJNxrQxmLz5pDUDK2aRgG41rLXA5iY
 Cc/cswfQzOz8AyDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D20013C83;
 Fri, 18 Feb 2022 12:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dBwFEV+RD2J8SAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 12:30:23 +0000
Date: Fri, 18 Feb 2022 13:30:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Martin Doucha <martin.doucha@suse.com>
Message-ID: <Yg+RXbUTOxK56iZa@pevik>
References: <20220211114401.24663-1-mdoucha@suse.cz> <YgZcu4frLBaKVXL2@yuki>
 <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
 <CAEemH2fqy3_t=-dbqE9Bx3VH6sZbNvM_bMon4zMukOh+rmw42Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fqy3_t=-dbqE9Bx3VH6sZbNvM_bMon4zMukOh+rmw42Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] 72b1728674 causing regressions [ [PATCH v2] Terminate
 leftover subprocesses when main test process crashes]
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Fri, Feb 11, 2022 at 9:30 PM Martin Doucha <mdoucha@suse.cz> wrote:

> > On 11. 02. 22 13:55, Cyril Hrubis wrote:
> > > Hi!
> > >> --- a/lib/tst_test.c
> > >> +++ b/lib/tst_test.c
> > >> @@ -1495,6 +1495,9 @@ static int fork_testrun(void)
> > >>              return TFAIL;
> > >>      }

> > >> +    if (tst_test->forks_child)
> > >> +            kill(-test_pid, SIGKILL);
FYI This broke all LTP network tests which use netstress.c binary,
they now randomly fails after "tst_test.c:1499: TINFO: Killed the leftover descendant processes"

I was thinking whether it's not actually kernel bug which is now visible,
but the behavior is the same on various kernels: SLES 5.14, openSUSE 5.16.8,
older Debian 5.3. and different VM setup (but disabled firewall, also randomly
failing means it's not a firewall issue).

Not sure now whether netstress.c should be altered or we should add flag to the
API to not run this cleanup.

DEBUGGING:

The reason is hidden, because netstress.c output is redirected and printed only
on error.

Sometimes it's just a warning:

# ./tcp_ipsec.sh -s 100:1000:65535:R65535
...
tcp_ipsec 1 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.Qn3NINBzja'
tcp_ipsec 1 TINFO: run client 'netstress -l -H 10.0.0.1 -n 100 -N 100 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 1 TWARN: netstress failed, ret: 2
tcp_ipsec 1 TPASS: netstress passed, median time 4 ms, data: 4 5 4 4
tcp_ipsec 2 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.Qn3NINBzja'
tcp_ipsec 2 TINFO: run client 'netstress -l -H 10.0.0.1 -n 1000 -N 1000 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 2 TPASS: netstress passed, median time 6 ms, data: 6 6 4 5 6
tcp_ipsec 3 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.Qn3NINBzja'
tcp_ipsec 3 TINFO: run client 'netstress -l -H 10.0.0.1 -n 65535 -N 65535 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 3 TPASS: netstress passed, median time 9 ms, data: 11 10 9 9 9
tcp_ipsec 4 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.Qn3NINBzja'
tcp_ipsec 4 TINFO: run client 'netstress -l -H 10.0.0.1 -A 65535 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 4 TPASS: netstress passed, median time 8 ms, data: 8 8 8 9 7
tcp_ipsec 5 TINFO: AppArmor enabled, this may affect test results
tcp_ipsec 5 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
tcp_ipsec 5 TINFO: loaded AppArmor profiles: none

# ./tcp_ipsec.sh -s 100:1000:65535:R65535
...
tcp_ipsec 1 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.4I7mEMaCeK'
tcp_ipsec 1 TINFO: run client 'netstress -l -H 10.0.0.1 -n 100 -N 100 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 1 TPASS: netstress passed, median time 6 ms, data: 5 5 6 6 6
tcp_ipsec 2 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.4I7mEMaCeK'
tcp_ipsec 2 TINFO: run client 'netstress -l -H 10.0.0.1 -n 1000 -N 1000 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 2 TWARN: netstress failed, ret: 2
tcp_ipsec 2 TPASS: netstress passed, median time 5 ms, data: 4 6 5 5
tcp_ipsec 3 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.4I7mEMaCeK'
tcp_ipsec 3 TINFO: run client 'netstress -l -H 10.0.0.1 -n 65535 -N 65535 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 3 TPASS: netstress passed, median time 10 ms, data: 10 10 8 9 10
tcp_ipsec 4 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.4I7mEMaCeK'
tcp_ipsec 4 TINFO: run client 'netstress -l -H 10.0.0.1 -A 65535 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 4 TPASS: netstress passed, median time 11 ms, data: 12 11 11 11 11
tcp_ipsec 5 TINFO: AppArmor enabled, this may affect test results
tcp_ipsec 5 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
tcp_ipsec 5 TINFO: loaded AppArmor profiles: none

Sometimes it's a hard failure, where we at least see the log:
tcp_ipsec 1 TPASS: netstress passed, median time 5 ms, data: 4 7 4 8 5
tcp_ipsec 2 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.rEORDqdaS6'
tcp_ipsec 2 TINFO: run client 'netstress -l -H 10.0.0.1 -n 1000 -N 1000 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 2 TPASS: netstress passed, median time 6 ms, data: 4 6 6 4 6
tcp_ipsec 3 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.rEORDqdaS6'
tcp_ipsec 3 TINFO: run client 'netstress -l -H 10.0.0.1 -n 65535 -N 65535 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 3 TWARN: netstress failed, ret: 2
netstress.c:642: TBROK: Server closed
tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
netstress.c:895: TINFO: connection: addr '10.0.0.1', port '33985'
netstress.c:896: TINFO: client max req: 100
netstress.c:897: TINFO: clients num: 2
netstress.c:902: TINFO: client msg size: 65535
netstress.c:903: TINFO: server msg size: 65535
netstress.c:817: TINFO: tcp_tw_reuse is already set
netstress.c:947: TINFO: TCP client is using old TCP API.
netstress.c:789: TINFO: '/proc/sys/net/ipv4/tcp_fastopen' is 1
netstress.c:476: TINFO: Running the test over IPv4
netstress.c:344: TBROK: connect(4, 10.0.0.1:33985, 16) failed: ECONNREFUSED (111)
netstress.c:344: TBROK: connect(3, 10.0.0.1:33985, 16) failed: ECONNREFUSED (111)

But with patch below it shows that server process is killed:

tcp_ipsec 1 TPASS: netstress passed, median time 5 ms, data: 6 5 5 4 5
tcp_ipsec 2 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.DId6DBCQ2W'
tcp_ipsec 2 TINFO: run client 'netstress -l -H 10.0.0.1 -n 1000 -N 1000 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times
tcp_ipsec 2 TINFO: ===== 1: remote netstress, ret: 0, cat tst_netload.log =====
tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
netstress.c:923: TINFO: max requests '10'
netstress.c:947: TINFO: TCP server is using old TCP API.
netstress.c:789: TINFO: '/proc/sys/net/ipv4/tcp_fastopen' is 1
netstress.c:678: TINFO: assigning a name to the server socket...
netstress.c:685: TINFO: bind to port 36103
netstress.c:706: TINFO: Listen on the socket '5'
tst_test.c:1499: TINFO: Killed the leftover descendant processes
=> HERE netstress server process is killed after TPASS

Summary:
passed   0
failed   0
broken   0
skipped  0
warnings 0
---

tcp_ipsec 2 TWARN: netstress failed, ret: 2
=> causing TWARN for client.

And hard failure:

tcp_ipsec 4 TINFO: ===== 5: remote netstress, ret: 0, cat tst_netload.log =====
tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
netstress.c:923: TINFO: max requests '10'
netstress.c:947: TINFO: TCP server is using old TCP API.
netstress.c:789: TINFO: '/proc/sys/net/ipv4/tcp_fastopen' is 1
netstress.c:678: TINFO: assigning a name to the server socket...
netstress.c:685: TINFO: bind to port 36709
netstress.c:706: TINFO: Listen on the socket '5'
tst_test.c:1499: TINFO: Killed the leftover descendant processes

Summary:
passed   0
failed   0
broken   0
skipped  0
warnings 0
---

tcp_ipsec 4 TWARN: netstress failed, ret: 2
netstress.c:642: TBROK: Server closed
tst_test.c:1457: TINFO: Timeout per run is 0h 05m 00s
netstress.c:874: TINFO: rand start seed 0xff9e
netstress.c:895: TINFO: connection: addr '10.0.0.1', port '36709'
netstress.c:896: TINFO: client max req: 100
netstress.c:897: TINFO: clients num: 2
netstress.c:900: TINFO: random msg size [5 65530]
netstress.c:817: TINFO: tcp_tw_reuse is already set
netstress.c:947: TINFO: TCP client is using old TCP API.
netstress.c:789: TINFO: '/proc/sys/net/ipv4/tcp_fastopen' is 1
netstress.c:476: TINFO: Running the test over IPv4
netstress.c:344: TBROK: connect(4, 10.0.0.1:36709, 16) failed: ECONNREFUSED (111)
netstress.c:344: TBROK: connect(3, 10.0.0.1:36709, 16) failed: ECONNREFUSED (111)

Summary:
passed   0
failed   0
broken   2
skipped  0
warnings 0
tcp_ipsec 4 TFAIL: expected 'pass' but ret: '2'

Kind regards,
Petr

+++ testcases/lib/tst_net.sh
@@ -728,6 +728,10 @@ tst_netload()
 
 	for i in $(seq 1 $run_cnt); do
 		tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1
+		tst_res_ TINFO "===== $i: remote netstress, ret: $ret, cat tst_netload.log ====="
+		cat tst_netload.log
+		printf -- "---\n\n"
+
 		if [ $? -ne 0 ]; then
 			cat tst_netload.log
 			local ttype="TFAIL"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
