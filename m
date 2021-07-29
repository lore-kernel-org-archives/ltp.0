From: Li Wang <liwang@redhat.com>
Date: Thu, 29 Jul 2021 16:52:29 +0800
Subject: [LTP] [PATCH] mbind01: accept MPOL_LOCAL when passing empty set
 for MPOL_PREFERRED
In-Reply-To: <CAASaF6yiAv=cw8OFAVoT9VHnbyrSapcphpuH85N-vDBpBMNY6Q@mail.gmail.com>
References: <3d693985aafc13fba1cd7c4fa807bbbddd015c7b.1627303875.git.jstancek@redhat.com>
 <CAEemH2fR-2pF5WpvgEQrNRVHJKYekXPwe72_KmQy4Bvh+NRs6Q@mail.gmail.com>
 <CAASaF6yiAv=cw8OFAVoT9VHnbyrSapcphpuH85N-vDBpBMNY6Q@mail.gmail.com>
Message-ID: <CAEemH2eqkQK+JYoawHK3s68oez26HmJtMJau1GvWm7a4-j26bw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 29, 2021 at 4:33 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> On Thu, Jul 29, 2021 at 9:27 AM Li Wang <liwang@redhat.com> wrote:
>
>>
>>
>> On Mon, Jul 26, 2021 at 8:53 PM Jan Stancek <jstancek@redhat.com> wrote:
>>
>>> When empty set is passed to MPOL_PREFERRED, memory is allocated
>>> on the node of the CPU that triggered the allocation.
>>>
>>> After kernel commit:
>>>   7858d7bca7fb ("mm/mempolicy: don't handle MPOL_LOCAL like a fake
>>> MPOL_PREFERRED policy")
>>> kernel returns stored policy as MPOL_LOCAL.
>>>
>>
>> As the MPOL_LOCAL has been setup as a real policy, I'm wondering should we
>> add more tests for it in the next? e.g.
>>
>
> Right, but we also need something in setup to avoid running it
> for kernels that don't support MPOL_LOCAL.
>

+1 we can achieve that in a separate patch.

I'm also planning to add one more function which named mbind_policy_name()
in the mbind.h to help make the log more readable, just like what we did in:
   static inline const char *mbind_flag_name(unsigned flag)

And yes, we can do that separately.


> You're right that parameters in tst_res message appear to be in wrong
> order.
>

Feel free to fix it while merging this patch.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210729/0dbee0c1/attachment.htm>
