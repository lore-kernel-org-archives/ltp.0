From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Jun 2021 11:26:32 +0800
Subject: [LTP] [PATCH] fix cpuhotplug04 check last cpu error
In-Reply-To: <20210628110316.01247283dbcd989cfe6f7c12@uniontech.com>
References: <20210628110316.01247283dbcd989cfe6f7c12@uniontech.com>
Message-ID: <CAEemH2dHj9jBfV0NNEDCx+4pijh6Mm-z68ZHa8Y8XGWdATxUkg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 28, 2021 at 11:03 AM <gouhao@uniontech.com> wrote:

> hi, LiWang,
>
> My cpu is Hygon C86 7185 32-core Processor, x86_64 architecture? kernel is
> 4.19.90
> Only cpu0 has no files?It doesn't seem to have anything to do with the
> kernel. I tried other kernels, too
>

Thanks for the info.

I checked my laptop (5.12.11-300.fc34.x86_64), it has no 'online' file in
the first cpu0 as well.
It seems common to consider cpu0 is always online, so it won?t have
?cpu0/online?.
(I got this view from google search ^)


But go back to your patch, does it really make sense to correct
the judgment of the last CPU?

If I understand correctly, the original judgment is purposely to
guarantee all CPUs can be safely offline, so if there is already
a cpu0 without an 'online' file, it will be filtered out, right? This
means all of the remaining hotplugged CPUs can be offline safely.
In this case, the judgment of the last CPU is losing effect as
expected. Why should we correct it?

Or, do you get any failures/abnormal in testing?



>
> Attached is a screenshot.
> ------------------------------
>
> *??????????*
>
> *UnionTech Software Technology Co., Ltd. *
>
> ???www.uniontech.com
>
>
>
> ?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
>
>
>
> This email message is intended only for the use of the individual or
> entity who/which is the intended recipient and may contain information that
> is privileged or confidential. If you are not the intended recipient, you
> are hereby notified that any use, dissemination, distribution or copying
> of, or taking any action in reliance on, this e-mail is strictly
> prohibited. If you have received this email in error, please notify
> UnionTech Software Technology  immediately by replying to this e-mail and
> immediately delete and discard all copies of the e-mail and the attachment
> thereto (if any). Thank you.
> ------------------------------------------------------------------
>
> Hi Hao,
>
> On Mon, Jun 28, 2021 at 9:16 AM Gou Hao <gouhao@uniontech.com> wrote:
>
>> From: gouhao <gouhao@uniontech.com>
>>
>>
>
>> Cpuhotplug04 uses get_hotplug_cpus when traversing,
>> get_hotplug_cpus will filter out cpu without online files,
>> and $cpus_num will be used to determine the last cpu num?
>
>
>
>>
>> If some cpu do not have an online file,
>> it will lead to an error in the judgment of the last cpu.
>>
>
> I'm wondering what kind of CPU does not have the online file, and which
> kernel version is being used? Is that test machine an x86 or MIPS?
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210628/64c58e22/attachment.htm>
