From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 09:08:54 +0100
Subject: [LTP] Errored: linux-test-project/ltp#80 (master - fc16fa6)
In-Reply-To: <58a2aa59571d7_43ff9934c2bac329246@32e3d83a-e575-4c3a-a21d-566d81cb1f3f.mail>
References: <linux-test-project/ltp+201407116+errored@travis-ci.org>
 <58a2aa59571d7_43ff9934c2bac329246@32e3d83a-e575-4c3a-a21d-566d81cb1f3f.mail>
Message-ID: <20170214080854.GA13786@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Build Update for linux-test-project/ltp
> -------------------------------------
> 
> Build: #80
> Status: Errored
> 
> Duration: 6 minutes and 49 seconds
> Commit: fc16fa6 (master)
> Author: Ngie Cooper
> Message: Minor update with respect to documentation bug for 2.6.33-rc1
> 
> - Change name from "Garrett" to "Ngie" (online handle)
> - Use their (gender neutral pronoun) instead of his/her for brevity
> 
> Signed-off-by: Ngie Cooper <yaneurabeya@gmail.com>
> 
> View the changeset: https://github.com/linux-test-project/ltp/compare/8967f960f820...fc16fa65a40f
> 
> View the full build log and details: https://travis-ci.org/linux-test-project/ltp/builds/201407116

Looking at the log this does not look like our problem. Either there is
some updater applet running in background that locks up dpkg database,
or there is a stale lock.

-- 
Cyril Hrubis
chrubis@suse.cz
