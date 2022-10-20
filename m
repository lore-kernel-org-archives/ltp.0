Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ECEC433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 12:24:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 011803CB192
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 14:24:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09F523CA31F
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:24:12 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8AC31600845
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 14:24:11 +0200 (CEST)
Received: by mail-pg1-x532.google.com with SMTP id b5so19062500pgb.6
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h6pULns+qQY1Po4vvaDyCaVvxCIblMJmbNC1QQmQENE=;
 b=yqZ6hBZLDOb2EVeQlO0IhC0GHlhNxRKdSL8dh4xD2XdMdUQZXL6YmmUUyNC4jSeu7N
 Zf3tvxAAtghuRzRk9qkebHNY5896JJrD6jwwARj/mDoRUeSCvpOc6jz8fI5cwv6cc3nf
 lRNDHMBe2yJabbZljgeDV1nWpJaueEK/af2S8UTQfu4Tc9JJr6jvFsXFWf/t4IKI4e9g
 2hHM4MYAz8X63/0Rd6/GT90FIPHNGBJG2S3DYYjcqViKX5PSmrsJrSUt36D4wzJjqMzS
 Wztbe8UlNwoP2L7vtU+00gAuZCyLRtuakxvaZ/29dAlMX8aj3OsxSCqPczG/4ZFCSwYM
 Wjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6pULns+qQY1Po4vvaDyCaVvxCIblMJmbNC1QQmQENE=;
 b=nvt+04G1i0bdpoTGRQZiDql32XKoaJZyEKar7qGPzh2My5xyfGpyFTjp2JAlFtoI9f
 MF+CRjn1AJHR+TGr0mZ6bGJBTY1v+Ncb014IUL6Jf0uN8vpxQRQfNhMbqEwsMcVwhrGC
 WiP0381lU7gUePKJno11XjWJWnxktbAKqMqZrpwbZBam4EhUPw3zkofzN4hpICx2bbjX
 5F/XIUmbH4Iqs27k0AGkoB0mxrtujnbmqwL3NKqOueNhbeZaB4EFckFVpfmblngmTnia
 ZhxpEe2fDlVnJPNDvTrGZiloY25V9PC7b77FWkXKV/K9p+FbTl3NmObajN3HMzwxYz0A
 G0pA==
X-Gm-Message-State: ACrzQf218aE/SNDQ7DhRoKHc8Al431TmVpeiDHP4S7pt0SC8nc5g+5Jy
 +zC8Izcwtlk4SR9iMs46hVdBlMof6wBQ4N/I
X-Google-Smtp-Source: AMsMyM5K+dB+FReGSQsmuOHBzSwLtsaMnSFIFlww22S4b0Sck06W5TEtyAqCXelQGFvv/BVWjv5u2A==
X-Received: by 2002:a63:1b0f:0:b0:46b:910:6cd9 with SMTP id
 b15-20020a631b0f000000b0046b09106cd9mr11656070pgb.5.1666268649970; 
 Thu, 20 Oct 2022 05:24:09 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419?
 ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a63d34e000000b0046b1dabf9a8sm11651433pgi.70.2022.10.20.05.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Oct 2022 05:24:09 -0700 (PDT)
Message-ID: <9894db50-6319-a818-c995-3ba9ab102c4b@daynix.com>
Date: Thu, 20 Oct 2022 21:24:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221013055904.28978-1-akihiko.odaki@daynix.com>
 <Y0gLqPfEQ1w6vEFy@pevik>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Y0gLqPfEQ1w6vEFy@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ftp/ftp01: Use tst_net.sh
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Thanks for reviewing. I have sent the new version with changes 
accordingly to your comments though I forgot to name it "v2".  Please 
check it.

Regarding paths to ASCII_FILES and BIN_FILES, the patch refers to 
$TST_NET_DATAROOT so it produces correct paths, prefixed with 
"$LTPROOT/testcases/bin/datafiles".

I guess your test failure is related to the error message "Not 
connected" rather than the path to files. The below is the output I got 
with v2:

[  320.638778] LTP: starting ftp (ftp01.sh)
ftp01 1 TINFO: timeout per run is 0h 5m 0s
Connected to 10.0.2.15 (10.0.2.15).
220 (vsFTPd 3.0.5)
331 Please specify the password.
230 Login successful.
200 Switching to Binary mode.
250 Directory successfully changed.
local: ascii.sm remote: ascii.sm
227 Entering Passive Mode (10,0,2,15,35,3).
150 Opening BINARY mode data connection for ascii.sm (220 bytes).
226 Transfer complete.
220 bytes received in 4.1e-05 secs (5365.85 Kbytes/sec)
221 Goodbye.
ftp01 1 TPASS: [ '220' = '220' ] passed as expected

Regards,
Akihiko Odaki

On 2022/10/13 21:59, Petr Vorel wrote:
> Hi Akihiko,
> 
>> This allows to use SSH rather than RSH.
> 
> Thanks for your work. First of all, code is not working, because ASCII_FILES and
> BIN_FILES are in "$LTPROOT/testcases/bin/datafiles. have look at approach in
> testcases/network/nfs/nfs_stress/nfs02.sh:
> LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"
> 
> Otherwise it fails:
> 
> ftp01 1 TINFO: timeout per run is 0h 5m 0s
> Not connected.
> Not connected.
> Not connected.
> Not connected.
> ls: cannot access 'bin.sm': No such file or directory
> ls: cannot access '/opt/ltp/testcases/bin/datafiles/bin.sm': No such file or directory
> ftp01 1 TINFO: Test Successful doing ftp get bin.sm binary
> Not connected.
> ftp: Can't chdir `/opt/ltp/testcases/bin/datafiles': No such file or directory
> Not connected.
> Not connected.
> Not connected.
> ftp01 1 TBROK: 'sum /tmp/LTP_ftp01.e9NUSqkHa3/bin.sm' failed on '': 'sum: /tmp/LTP_ftp01.e9NUSqkHa3/bin.sm: No such file or directory'
> ftp01 1 TINFO: AppArmor enabled, this may affect test results
> ftp01 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> ftp01 1 TINFO: loaded AppArmor profiles: none
> 
> ...
> 
> Or have I miss something? >
> When we convert file to use LTP new API (shell API in this case:
> https://github.com/linux-test-project/ltp/wiki/Shell-Test-API)
> we do cleanup the code.
> 
> NFS tests or other shell tests which use tst_net.sh and *not* set
> TST_USE_LEGACY_API=1 (i.e. rewritten to use LTP new shell API) are good
> examples.
> 
> ftp01.sh requires at least this cleanup:
> * remove useless comments like "FUNCTION:  do_setup"
> * code cleanup of do_test: having several loops is really crazy,
> how about write functions and pass them parameters?
> * please use $( ... ) instead of ` ... `.
> * use local to declare new variables
> * I'd remove sleep option
> * replace GPL with:
> # SPDX-License-Identifier: GPL-2.0-or-later
> * update copyright
> 
> Proper API use
> * tst_require_cmds should be replaced by TST_NEEDS_CMDS at the top.
> Even if you keep to use tst_require_cmds awk ftp
> this line is useless (1) tst_brk quits testing 2) we use ssh, why to mention
> .rhosts?):
> [ $? = 0 ] || tst_brk TBROK "Check .rhosts file on remote machine."
> * instead of "for i in binary ascii; do" I'd use:
> 
> TST_TESTFUNC=do_test
> TST_CNT=4
> TST_NEEDS_TMPDIR=1
> LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"
> 
> test_ftp()
> {
> 	for j in $*; do
> 	done
> }
> 
> do_test()
> {
>      case $1 in
>      1) test_get $BIN_FILES;;
>      2) test_get $ASCII_FILES;;
>      3) test_put $BIN_FILES;;
>      4) test_put $ASCII_FILES;;
>      esac
> }
> 
> test_get()
> {
> 	local sum1 sum2
> 
> 	for file in $*; do
> 		{
> 			echo "user $RUSER $PASSWD"
> 			echo "$i"
> 			echo "cd $TST_NET_DATAROOT"
> 			echo "get $file"
> 			echo "quit"
> 		} | ftp -nv $RHOST
> 
> 		sum1="$(ls -l $file | awk '{print $5}')"
> 		sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
> 		rm -f $file
> 		EXPECT_PASS "[ '$sum1' = '$sum2' ]"
> 	done
> }
> 
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
