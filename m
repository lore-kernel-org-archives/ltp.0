From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Date: Tue, 23 Feb 2021 17:27:09 -0800
Subject: [LTP] [PATCH v3 0/2] IMA: Add test for dm-crypt measurement
In-Reply-To: <0a25f4b7ed53566b13211d5aeea18e7f13f12bd7.camel@linux.ibm.com>
References: <20210223225930.27095-1-pvorel@suse.cz>
 <0a25f4b7ed53566b13211d5aeea18e7f13f12bd7.camel@linux.ibm.com>
Message-ID: <e8232b66-8081-090e-4e26-0e1d2544e752@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 2021-02-23 4:43 p.m., Mimi Zohar wrote:
> Hi Petr,
> 
> On Tue, 2021-02-23 at 23:59 +0100, Petr Vorel wrote:
>> Hi!
>>
>> I updated Tushar's patchset to speedup things.
>>
Thank you. :)

>> Changes v2->v3
>> * rename function s/check_ima_ascii_log_for_policy/test_policy_measurement/
>> * move tst_res TPASS/TFAIL into test_policy_measurement()
>> * drop template=ima-buf (see Lakshmi's patch [1] and discussion about
>>    it, it will be removed from ima_keys.sh as well)
Makes sense.

>> * moved ima_dm_crypt.sh specific changes to second commit
>> * further API and style related cleanup
>>
>> Could you please check this patchset?
I reviewed the patchset.
Patch 1 looks ok. (generalize key measurement tests)
Patch 2 won't work as is, since the dm kernel code is not upstreamed
yet. (see my comments below for more context)

> 
> I'm not sure about the status of the associated IMA dm-crypt kernel
> patch set.  It hasn't even been reviewed, definitely not upstreamed.
>   I would hold off on upstreaming the associated ltp test.
> 
That is correct.

The device mapper measurement work is being revisited - to cover aspects
like more DM targets (not just dm-crypt), better memory management, more
relevant attributes from the DM targets, other corner cases etc.

Therefore, even though the first patch of the series "generalize key
measurement tests", would be useful for other tests; I will have to
revisit the second patch, "dm-crypt measurements", to address the
DM side changes I mentioned above.

To summarize,
  - you may upstream the first patch (generalizing the key
    measurements). It would be useful for us while writing more tests in
    this space.

  - but please hold off upstreaming the second patch (dm-crypt test)
    as Mimi has suggested.

Thanks,
Tushar

> thanks,
> 
> Mimi
> 
