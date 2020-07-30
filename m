From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Jul 2020 17:25:05 +0200
Subject: [LTP] [PATCH V2 2/2] libs: sigwait: Get rid of REPORT_SUCCESS()
 macro
In-Reply-To: <20200729151317.evk2cphq7tclcww5@vireshk-mac-ubuntu>
References: <53c9ed8dc17ea6fa0b46502cd1c724a3a8539c8c.1595842740.git.viresh.kumar@linaro.org>
 <e964452fdb6c526a2cc61650573905e27adb83d5.1595842740.git.viresh.kumar@linaro.org>
 <20200729144054.GI7152@yuki.lan>
 <20200729151317.evk2cphq7tclcww5@vireshk-mac-ubuntu>
Message-ID: <20200730152505.GF3457@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Unfortunately half of this patch does not apply after the changes in the
> > first one, can you please rebase?
> 
> I didn't see any issues with normal rebase of this patch over the other one, git
> probably resolved issues itself.

Well the original v2 patch contains references to the sigprocmask()
lines that the previous patch changes, what I got bunch of these:

Checking patch libs/libltpsigwait/sigwait.c...
error: while searching for:
        child = create_sig_proc(signo, 1, 0);

        TEST(sigwaitinfo(&sigs, &si, NULL));
        REPORT_SUCCESS_COND(signo, 0, si.si_pid == child
                            && si.si_code == SI_USER
                            && si.si_signo == signo, "Struct siginfo mismatch");

        TEST(sigprocmask(SIG_SETMASK, &sigs, &oldmask));
        if (TST_RET == -1)

Because the sigprocmask(SIG_SETMASK, &sigs, &oldmask)); couldn't be found.

The patch that you resend has corrected these.

-- 
Cyril Hrubis
chrubis@suse.cz
