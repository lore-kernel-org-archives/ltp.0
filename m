From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Aug 2018 15:58:35 +0800
Subject: [LTP] [PATCH] pty: using tcgetattr() to get attributes before
 re-setting it
In-Reply-To: <CAEemH2f7BZRNXJTjD8abR6QMJRRQc+C0F=Z_4Q2j+BdLeo07eg@mail.gmail.com>
References: <20180528103936.22538-1-liwang@redhat.com>
 <5B0CFB5C.5040702@cn.fujitsu.com>
 <CAEemH2fr-5HAJdFL_Br7u2bsry5E3j_dwaVnnJFdm4wFTWsA0w@mail.gmail.com>
 <20180815105009.GA1379@rei>
 <CAEemH2f7BZRNXJTjD8abR6QMJRRQc+C0F=Z_4Q2j+BdLeo07eg@mail.gmail.com>
Message-ID: <CAEemH2domA0jqQVUOXjLYrh_VdP54Y86vOO66E714nnYDCJDVg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Aug 16, 2018 at 12:49 PM, Li Wang <liwang@redhat.com> wrote:

>
>
> On Wed, Aug 15, 2018 at 6:50 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> I'm looking into these patches now, so if I get it right we should:
>>
>
> Thanks for taking care of this.
>
>
>>
>> * Add EXTPROC into lapi
>> * Get the termios value, or it with the requested flags, then apply
>>   tcsetattr()
>> * Exit the test with TCONF if we get EINVAL from tcsetattr()
>>
>> Would that work for both of you?
>>
>
> I think that's right.
>
> But maybe we have to handle the ICANON nonuniform behavior too.
>
> As YangXiao mentioned that, reading pts will be blocked on rhel6 forever
> if we don't give
> newline('\n') to ptmx, but this issue not exist on rhel7.
>
>
To avoid the block issue we can just add newline('\n') in the test
forwardly, I have confirmed that
won't have any impact on the bug's reproducible in bad(< kernel-4.15)
kernel.
I will resend a new patch to fix all these issues above.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180816/69b733b6/attachment.html>
