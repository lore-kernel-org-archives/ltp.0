From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Feb 2019 14:31:56 +0100
Subject: [LTP] [PATCH 1/5] syscalls/fanotify03: defined additional tcase
 members for added control
In-Reply-To: <CAOQ4uxhbWmS2_jOjenZA11jk_TNwBE8KNUs+Na-vC13gPt+_2g@mail.gmail.com>
References: <20190122223526.GA32694@lithium.mbobrowski.org>
 <20190221164234.GD17813@rei.lan>
 <CAOQ4uxhbWmS2_jOjenZA11jk_TNwBE8KNUs+Na-vC13gPt+_2g@mail.gmail.com>
Message-ID: <20190226133156.GA3281@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I see the problem.
> It is based on an older version of
> syscalls/fanotify03: add test for FAN_MARK_FILESYSTEM permission events
> 
> You removed support_perm_events on commit or maybe I sent another
> version based on your review - not sure.
> 
> Attached the missing prerequisite patch.
> 
> You may choose to drop support_perm_events again or add a test
> for kernel permission events support in setup(), but we do need to
> distinguish between support_exec_events (which comes in a later patch)
> and FAN_MARK_FILESYSTEM support, as exec events may be backported
> to distro stable kernels and FAN_MARK_FILESYSTEM is less likely to be
> backported.

Unfortunately that did the trick only for the first patch, the rest is
still broken :-(.

-- 
Cyril Hrubis
chrubis@suse.cz
