From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Fri, 24 Jul 2020 12:19:28 -0400
Subject: [LTP] [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
In-Reply-To: <20200724131845.GB24626@dell5510>
References: <20200724070038.29491-1-pvorel@suse.cz>
 <20200724070038.29491-2-pvorel@suse.cz>
 <1595592111.5211.246.camel@linux.ibm.com> <20200724131845.GB24626@dell5510>
Message-ID: <7cec65cc-efc7-045e-e905-07ad18ad24be@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 7/24/20 9:18 AM, Petr Vorel wrote:
> Hi all,
>
>> On Fri, 2020-07-24 at 09:00 +0200, Petr Vorel wrote:
>>> From: Lachlan Sneff <t-josne@linux.microsoft.com>
>>> IMA policy can be set to measure the command line passed in the kexec
>>> system call. Add a testcase that verifies that the IMA subsystem
>>> correctly measure the cmdline specified during a kexec.
>>> Note that this test does not actually reboot.
>>>
>>>
>>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>>> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>> ---
>>> Hi,
>>> sent version with few my fixes.
>>> @Mimi: could you please have a quick look? (I know you reviewed previous
>>> version.)
> @Mimi, @Lachlan: if you both ack my changes, I can fix the code before merging.
> If there are more changes needed and thus Lachlan plan new version, please use
> my patches from https://patchwork.ozlabs.org/project/ltp/list/?series=191990&state=*
> (download https://patchwork.ozlabs.org/series/191990/mbox/ and import it with "git am")
> or clone my github fork and use kexec.v3.fixes branch:
> https://github.com/pevik/ltp/tree/ima/kexec.v3.fixes).
Hi Petr, these changes look good to me. I'm not exactly sure the 
convention here,
since I originally wrote the patch, but feel free to mark me as 
Signed-off-by.
>
> Kind regards,
> Petr
Thank you for working on this!
Lachlan
