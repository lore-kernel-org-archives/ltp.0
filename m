From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Aug 2016 16:07:25 +0100
Subject: [LTP] [PATCH] remap_file_pages: Remove since corresponding
 syscall is depricated
In-Reply-To: <248280847.496370.1471442572726.JavaMail.zimbra@redhat.com>
References: <1471442189-29937-1-git-send-email-yuriy.kolerov@synopsys.com>
 <248280847.496370.1471442572726.JavaMail.zimbra@redhat.com>
Message-ID: <CAFEAcA_065KQ2BWQkeQg8Bgdx6ZVdmVopOvwX_EP5=FTt0mGnA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17 August 2016 at 15:02, Jan Stancek <jstancek@redhat.com> wrote:
> From: "Yuriy Kolerov" <yuriy.kolerov@synopsys.com>
>> This system call is deprecated since Linux 3.16 and will
>> eventually be replaced by a slower in-kernel emulation. See:
>
> It already is replaced by emulation in latest upstream:
>   commit c8d78c1823f46519473949d33f0d1d33fe21ea16
>   Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>   Date:   Tue Feb 10 14:09:46 2015 -0800
>     mm: replace remap_file_pages() syscall with emulation
>
> But as long as interface is same, why not keep the test?
> What about testing older kernels from various distros?

For that matter, it's presumably useful to test
the in-kernel emulation itself...

thanks
-- PMM
