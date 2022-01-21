Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A2C433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 08:24:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027513C96E9
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:24:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 853D73C9424
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 09:24:01 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EDBB81000F20
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 09:24:00 +0100 (CET)
Received: by mail-il1-x12c.google.com with SMTP id i1so1050238ils.5
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 00:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=7pmNfjqj+A/zUao8NlMxxYvsOTCoyElb96SDSxWCjpg=;
 b=leuo4SFOHEVsr/J2wdNQREy+Kp5qOoO3URGILlmUJuJsB8pLpMhcL7IklXFC6j/VFu
 YQ/stwm+/j3W3RSix4eV/7UnQyP+fasNdaZaOEY7RBmf4qNcKkaDF/clQfZVdYL3adi4
 kEiPLkoJPDRq4XYF/8sZ+ZhREXtmnJYfT+9UOraoaVoLGtbTLXcR7uX3egmV+Dz5uIe+
 Cz9xXu+3p83iQM632bmuf5DGMETRFZIA0fnRX7uOIZc8m9ZRAPBOAxqE/so04mjXvuTX
 CaTWptmsVSYYYzwuUuh7sziFN/+J7vcc2DYDS6jJ7oWItcyOgXIpBCa2Rk/MG3X76ndv
 dpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7pmNfjqj+A/zUao8NlMxxYvsOTCoyElb96SDSxWCjpg=;
 b=SimEcJ5t9wmv7qCQqq2CmkpDcMG8HwyfBP1UazYqADXJyz6yvi/EWChWOIZl+E770N
 2lfSgo69rhsbbLOQaunj82rSNwjmSNi1iRUtNWA4jj7Ki9IlELmLxJ0WM4OgFbvsJsSX
 JKIVHBRyM8rtV0QMOeNJvtrSqFo+93ngC8N1/IJUCK4PhLJHr7dFq04VPHUJjgyLASy3
 bbnRT2rTCLk0cXP+C6yVaAjcXV1/Ic+DH7ply5OGTzZY6NvaLPBXQOd/uppE5c/8gMcx
 l3Aa6zT7wlQ3DHwVrgZoJR39D3kvICMXm1Kjv0DoBv5Av8C0QJJcQ5uTaMNgQI6WkVS2
 +HWw==
X-Gm-Message-State: AOAM531ZF81cjOd4KZkdcPDA9gt4iUOqizfVrV6LRKsk50d+e0X4ruWU
 93eLrrd+S+lJCgl8Emz5UbJROPhoFIee3T5rt8hGNhCirS14KojL
X-Google-Smtp-Source: ABdhPJxfzB36yV+wzYShKNRYjOSw7KhMPBaO0jFnsmlN9wGZIZysAsEXsotwt9hK7VuYbep0AVCGn5Z0x5P23p/Z9nw=
X-Received: by 2002:a92:c243:: with SMTP id k3mr1466576ilo.37.1642753439473;
 Fri, 21 Jan 2022 00:23:59 -0800 (PST)
MIME-Version: 1.0
From: Kautuk Consul <kautuk.consul.80@gmail.com>
Date: Fri, 21 Jan 2022 13:53:50 +0530
Message-ID: <CAKWYkK3a-Qp5bZNyL67JkTtzD=_55c0tk7eb69rsikYr+r=QqA@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] msgstress03: "Fork failed (may be OK if under stress)"
 problem observed on qemu.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi All,

I am running RISCV kernel on qemu and on executing the msgstress03
testcase I observe that it fails with the following failure
log:
msgstress03    0  TINFO  :  Cannot read session user limits from
'/sys/fs/cgroup/user.slice/user-0.slice/pids.max'
msgstress03    0  TINFO  :  Found limit of processes 10178 (from
/sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max)
msgstress03    0  TINFO  :  Requested number of processes higher than
limit (10000 > 9991), setting to 9991
msgstress03    1  TFAIL  :  msgstress03.c:163:  Fork failed (may be OK
if under stress)

The kernel dmesg log shows the following log:
[ 3731.980951] cgroup: fork rejected by pids controller in
/user.slice/user-0.slice/session-c1.scope

I put some logs into the kernel and confirmed that the cgroup limit of
forks, i.e. 10178 is being exceeded by this msgstress03 testcase due
to which it fails to fork() in a legitimate manner.
On analyzing the msgstress03 testcase code I see that the test-case
tends to assume that the "nprocs" number of forks are done
and it is correctly restricted to the limit which is 9991. However,
the total number of forks is much larger (i.e. 2*nprocs) as the nproc
children do an additional fork within do_test().

Due to this on slower machines (where the children do not execute fast
enough and the parent doesn't do a wait syscall fast
enough) this testcase can/will fail. The initial children may even
reach exit(), but they will remain as defunct as the parent process
wil not necessarily be able to execute the wait() syscall on all them
fast enough to ensure that the pids become free for use.

I made the following changes and the test-case passed:
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
index 3cb70ab18..75cfc109d 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
@@ -131,7 +131,7 @@ int main(int argc, char **argv)
        /* Set up array of unique keys for use in allocating message
         * queues
         */
-       for (i = 0; i < nprocs; i++) {
+       for (i = 0; i < nprocs/2; i++) {
                ok = 1;
                do {
                        /* Get random key */
@@ -157,7 +157,7 @@ int main(int argc, char **argv)
         * of random length messages with specific values.
         */

-       for (i = 0; i < nprocs; i++) {
+       for (i = 0; i < nprocs/2; i++) {
                fflush(stdout);
                if ((pid = FORK_OR_VFORK()) < 0) {
                        tst_brkm(TFAIL,
@@ -191,11 +191,11 @@ int main(int argc, char **argv)
                }
        }
        /* Make sure proper number of children exited */
-       if (count != nprocs) {
+       if (count != nprocs/2) {
                tst_brkm(TFAIL,
                         NULL,
                         "Wrong number of children exited, Saw %d, Expected %d",
-                        count, nprocs);
+                        count, nprocs/2);
        }

The reason why other test-cases like msgstress04 dont fail is because
the nprocs value is set with a different calculation.
Specifically, I observe that the msgstress04 testcase uses only
free_pids / 2 pids instead of the full free_pids number of processes.

Can someone confirm my findings ? If needed I can also send out a
patch with my above nprocs/2 changes if required.
Or, if there is any better fix or opinion kindly reply back to us.

Thanks and Regards.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
