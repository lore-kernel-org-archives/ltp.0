From: Sandy Sun <a22017@motorola.com>
Date: Fri, 9 Oct 2015 22:31:13 -0500
Subject: [LTP] Fwd: proc01 causing kernel panic
In-Reply-To: <CANKSX+GV4bFEu1t2OGL1Vww04vzjpWx-5xr9yYwCsZZsM6tUHw@mail.gmail.com>
References: <CANKSX+HCdoZ2+fk7eTkiiysAHhOds-Vdy87ONhC5ecrHD0C8iw@mail.gmail.com>
 <CANKSX+GV4bFEu1t2OGL1Vww04vzjpWx-5xr9yYwCsZZsM6tUHw@mail.gmail.com>
Message-ID: <CACwVHNqchOYTKoPWJdLzEvjhJZLAqYCQkuikh5sGqR3Xd7ozog@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Srikanth,

Which HW are you testing? Most of time, /proc can't be ready on some HW. It
would cause kernel panic.

BRs,
Sandy

On Fri, Oct 9, 2015 at 9:36 PM, $rik@nth <srikanth007m@gmail.com> wrote:

> Hi LTP,
>
> Can anyone help in debugging the proc01 test which is causing the kernel
> panic.
>
> Kernel verison: 3.18
> LTP Version: LTP-09042015
>
> Find the attached kernel signatures. strace file greater than 2MB and
> i can't forward it to the group.
>
> --
> Thanks & Regards,
> M.Srikanth Kumar.
>
>
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151009/47d2f557/attachment.html>
