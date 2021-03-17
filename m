From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Mar 2021 19:08:27 +0800
Subject: [LTP] [PATCH v2 1/1] brk02: Add test for removing more than one
 VMA
In-Reply-To: <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
References: <20210224213114.2976705-1-Liam.Howlett@Oracle.com>
 <20210224213114.2976705-2-Liam.Howlett@Oracle.com>
Message-ID: <CAEemH2cKR98HvHZ6OYJpLpaX9-5hfhTak650=DtU-q2Yoo6kbA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Liam, Petr,

Liam Howlett <liam.howlett@oracle.com> wrote:


> ...
> +       if (mprotect(addr - page_size, page_size,
> +                    PROT_READ|PROT_WRITE|PROT_EXEC)) {
> +               tst_res(TFAIL, "Cannot mprotect new VMA.");
> +               return;
> +       }
>

We got permission denied here while performing the brk02 on
x86_64/s390x(kernel-4.18~). After looking at the manual page of
mprotect(), seems the access issue caused by PROT_EXEC.

"
POSIX says that the behavior of mprotect() is unspecified if it is applied
to a region of memory that was not obtained via mmap(2).
...
Whether  PROT_EXEC has any effect different from PROT_READ
depends on processor architecture, kernel version, and process state.
If READ_IMPLIES_EXEC is set in the process's personality flags
(see personality(2)), specifying PROT_READ will implicitly add PROT_EXEC.
"

# ./brk02
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
brk02.c:41: TFAIL: Cannot mprotect new VMA

After removing the PROT_EXEC:

# ./brk02
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
brk02.c:56: TPASS: munmap at least two VMAs of brk() passed


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210317/0b7d83c6/attachment.htm>
