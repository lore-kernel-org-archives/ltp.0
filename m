From: Jakub =?unknown-8bit?q?Ra=C4=8Dek?= <jracek@redhat.com>
Date: Tue, 21 Mar 2017 18:46:35 +0100
Subject: [LTP] [PATCH v4 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <20170321152711.GC32105@rei.lan>
References: <1489595740-26159-1-git-send-email-jracek@redhat.com>
 <1489595740-26159-6-git-send-email-jracek@redhat.com>
 <20170321152711.GC32105@rei.lan>
Message-ID: <f86d5a51-50a3-6acb-03d6-58677eddb583@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

actually yes, I would like to add some other tests. The multiprocessing 
tests are missing for now. This is because I didn't like how it is done
in original testsuite, and also this patchset seems large enough already.

Thanks!

On 03/21/2017 04:27 PM, Cyril Hrubis wrote:
> Hi!
>>  .../syscalls/memfd_create/memfd_create_common.h    | 457 +++++++++++++++++++++
>
> Just a short question before further review, do you intend to write more
> testcases that will use this header?
>
> Since as it is the memfd_create02 needs only the memfd_new function and
> the ASSERT that memfd_create() is implemented in kernel and including
> that header in memfd_create02.c yields a few "unused function" warnings.
> There are a couple of ways how to fix that but the easies solution would
> be moving these functions into the memfd_create01.c in a case that
> these are not needed for further testcases.
>

-- 
Regards,
     Jakub
