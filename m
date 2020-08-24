From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Mon, 24 Aug 2020 10:24:06 -0700
Subject: [LTP] [LTP v4 1/5] IMA/ima_keys.sh: Fix policy content check
 usage
In-Reply-To: <20200824171943.GA15693@dell5510>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-2-pvorel@suse.cz> <20200824171943.GA15693@dell5510>
Message-ID: <9bd0a70c-ba3f-3538-cf4f-fddcdb14c383@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/24/20 10:19 AM, Petr Vorel wrote:

Hi Petr,

> 
>> require_ima_policy_content cannot be used in subshell $() evaluation,
>> because tst_brk does not quit the test. It calls cleanup for the
>> subshell process and main process then continue:
> ...
> 
> Merged this one to at least fix ima_keys.sh test.
> I'll wait little longer before merging the rest of v4 patchset
> https://patchwork.ozlabs.org/project/ltp/list/?series=196621
> 
Sorry for the late response.

I applied your v4 patches and ran keys tests. The issues reported 
earlier by Mimi are fixed.

thanks,
  -lakshmi



