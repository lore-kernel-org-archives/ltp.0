From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 29 Sep 2015 11:22:44 +0200
Subject: [LTP] membarrier test-case?
In-Reply-To: <20150929091650.GA24796@rei.suse.cz>
References: <CA+icZUUi_yNcy8pwk0nzctar_pWHrrm0EViV4sAfXr2oM=kYng@mail.gmail.com>
 <20150929091650.GA24796@rei.suse.cz>
Message-ID: <CA+icZUXpsYL6d+DkN2Np0d=EpP3a5C2uoyc-Bz2UX0KhKtRTyA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 29, 2015 at 11:16 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> while digging into a llvmlinux issue with CLANG v3.7 [1] I saw a
>> "membarrier_test.c" in selftests-dir in Linux v4.3-rcN.
>>
>> Does something similiar exist in LTP?
>
> No. The membarrier syscall is not part of any officially released kernel
> yet. Once it gets released and once somebody has time to look into it we
> may add testcases for it into LTP.
>

So, wait for Linux v4.3.

- Sedat -
