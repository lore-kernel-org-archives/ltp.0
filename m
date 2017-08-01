From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 1 Aug 2017 17:04:32 +0200
Subject: [LTP] [PATCH v3 00/15] Convert LTP mem/testcase to new API
In-Reply-To: <20170718082312.3946-1-liwang@redhat.com>
References: <20170718082312.3946-1-liwang@redhat.com>
Message-ID: <20170801150432.GA3925@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've pushed this patches, after careful testing and with many changes,
thanks.

Most of the changes were more or less cosmetic, such as removing -1
handling after SAFE_FORK(), make use of more SAFE_MACROS() etc.

But there were some problems as well. It introduced a compilation
failure on 32bit for min_free_kbytes.c since it removed the total_mem
variable that is used only on 32bit.

The ksm06.c cleanup had to be changed, since in a case that
merge_across_nodes is missing it attempted to run cleanup (previously
there was NULL cleanup pointer for TCONF!) and failed the test. There is
probably more unvanted cleanups possibly run for the ksm test, we should
have a look at these later.

I've also reverted the change to the thp01 in the runtest file since I
belive that the value was reduced only for testing and slipped to the
patchset by accident.

I've changed the patch that adds possibility to disable timeouts, mainly
so that the API is consistent, which means that the tst_set_timeout()
takes -1 as parameter as well + wrote documentation for the change.

Also unsolved is a problem with TCONF tests. At the moment newlib test
fails if we pass any parameters to it, since the option parsing runs
with the tst_test structure without the option stucture. This fails, for
instance, ksm test if they were compiled out since we pass parameters to
them in the runtest file. I will have to think about this a bit more and
figure out a good solution.

-- 
Cyril Hrubis
chrubis@suse.cz
