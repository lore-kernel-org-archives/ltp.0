From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Sep 2021 13:59:36 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/setresuid01: Convert to new API
In-Reply-To: <3a764f27-b453-0aab-4938-7b7b34496885@suse.cz>
References: <20210913144454.22992-1-mdoucha@suse.cz>
 <20210913144454.22992-2-mdoucha@suse.cz>
 <3a764f27-b453-0aab-4938-7b7b34496885@suse.cz>
Message-ID: <YUCOqP9ObE+CxQCQ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Oops, I've accidentally copy-pasted the wrong SPDX header to all three
> setresuid tests. Patch 1 is correct as is but patches 2-4 should have
> GPL-2.0-or-later instead. Please update it before merge.

I've fixed that and also removed useless comments from the test
structure in setresgid03.c and pushed the patchset, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
