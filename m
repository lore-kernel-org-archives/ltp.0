From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Oct 2018 16:13:21 +0200
Subject: [LTP] Broken: linux-test-project/ltp#1087 (master - e816127)
In-Reply-To: <5bc74297c66d_43fb51dcf2da03635fd@4b4f3520-7c9e-4919-8edc-54be81f81d1b.mail>
References: <linux-test-project/ltp+442701001+broken@travis-ci.org>
 <5bc74297c66d_43fb51dcf2da03635fd@4b4f3520-7c9e-4919-8edc-54be81f81d1b.mail>
Message-ID: <20181017141321.GD31018@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Build Update for linux-test-project/ltp
> -------------------------------------
> 
> Build: #1087
> Status: Broken
> 
> Duration: 10 mins and 19 secs
> Commit: e816127 (master)
> Author: Ammy Yi
> Message: Add Intel PT full trace mode basic test case
> 
> This test will do Intel PT full trace mode with test case PID to check
> if enable/stop/trace generation works with Intel PT.
> 
> Signed-off-by: Ammy Yi <ammy.yi@intel.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> 
> View the changeset: https://github.com/linux-test-project/ltp/compare/75dd92ce36ea...e816127e5d8e
> 
> View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/442701001?utm_medium=notification&utm_source=email

Looks like we need configure checks for the struct perf_event_mmap_page,
I will have a look into that.

-- 
Cyril Hrubis
chrubis@suse.cz
