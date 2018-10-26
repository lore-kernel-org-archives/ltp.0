From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Oct 2018 14:18:38 +0530
Subject: [LTP] mainline 4.19.0/a978a5b8d83f: LTP syscalls keyctl05 failed
In-Reply-To: <283225473.62415253.1540452807970.JavaMail.zimbra@redhat.com>
References: <01000166a88efd1a-9d85efc5-f72f-42de-bf0f-bfd637aff1d1-000000@email.amazonses.com>
 <CA+G9fYtKcgedA=S1QdwaLK8PTO958aeqXM7jdpqFTOcj1Qm68w@mail.gmail.com>
 <283225473.62415253.1540452807970.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYt22tRHf_STN3HdCgsnRYtzcz23fnBXAOk9Hfwmwc45fA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan,

On Thu, 25 Oct 2018 at 13:03, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
> > LTP syscalls keyctl05 failure was detected on -next (
> > 4.19.0-rc6-next-20181005) and
> > reported to LTP mailing list.
> > Now we have seen this issues on -mainline kernel.
> >
> > keyctl05 failure not a kernel bug instead test case "keyctl05" needs
> > to be updated according to the latest upstream changes.
>
> I'll look into it, unless someone already has a patch.

Thanks for the test case fix patch :)

- Naresh
>
> Regards,
> Jan
>
