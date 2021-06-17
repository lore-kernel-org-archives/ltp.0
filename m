From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 17 Jun 2021 08:45:05 +0100
Subject: [LTP] [PATCH v4 2/3] API: Remove TEST macro usage from library
In-Reply-To: <CAEemH2eNrTa_wNZhPGNhRPgeF3yQFE8pNXOiPuZa3D0x9s=EnQ@mail.gmail.com>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
 <20210615074045.23974-2-rpalethorpe@suse.com>
 <CAEemH2eNrTa_wNZhPGNhRPgeF3yQFE8pNXOiPuZa3D0x9s=EnQ@mail.gmail.com>
Message-ID: <87fsxh3pfi.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
>
> On Tue, Jun 15, 2021 at 3:41 PM Richard Palethorpe via ltp
> <ltp@lists.linux.it> wrote:
>>
>> The test author is guaranteed that the LTP library will not change the
>> TST_RET and TST_ERR global variables. That way the test author can use
>> the TEST macro then call other library functions before using TST_RET,
>> TST_ERR or TTERRNO.
>
> I guess the inline function in the header files also should be
> considered, right?
>
> lapi/clone.h:           TEST(syscall(__NR_clone3, NULL, 0));
> lapi/fsmount.h:         TEST(syscall(__NR_fsopen, NULL, 0));
> lapi/init_module.h:               TEST(syscall(__NR_finit_module, 0, "", 0));
> lapi/io_uring.h:                TEST(syscall(__NR_io_uring_setup, NULL, 0));
> lapi/name_to_handle_at.h:       TEST(name_to_handle_at(dfd, pathname,
> &fh, &mount_id, 0));
> lapi/openat2.h:         TEST(syscall(__NR_openat2, -1, NULL, NULL, 0));

Yes, I guess we need to explicitly scan the headers. Thanks!

-- 
Thank you,
Richard.
