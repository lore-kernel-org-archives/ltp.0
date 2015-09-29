From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2015 11:16:50 +0200
Subject: [LTP] membarrier test-case?
In-Reply-To: <CA+icZUUi_yNcy8pwk0nzctar_pWHrrm0EViV4sAfXr2oM=kYng@mail.gmail.com>
References: <CA+icZUUi_yNcy8pwk0nzctar_pWHrrm0EViV4sAfXr2oM=kYng@mail.gmail.com>
Message-ID: <20150929091650.GA24796@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> while digging into a llvmlinux issue with CLANG v3.7 [1] I saw a
> "membarrier_test.c" in selftests-dir in Linux v4.3-rcN.
> 
> Does something similiar exist in LTP?

No. The membarrier syscall is not part of any officially released kernel
yet. Once it gets released and once somebody has time to look into it we
may add testcases for it into LTP.

-- 
Cyril Hrubis
chrubis@suse.cz
