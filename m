From: Ignaz Forster <iforster@suse.de>
Date: Fri, 14 Jun 2019 16:37:23 +0200
Subject: [LTP] [PATCH v4 4/4] ima: Add overlay test + doc
In-Reply-To: <20190614141449.GA24614@dell5510>
References: <20190613161414.29161-1-pvorel@suse.cz>
 <20190613161414.29161-5-pvorel@suse.cz>
 <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
 <20190614141449.GA24614@dell5510>
Message-ID: <794ee977-463f-6670-fac6-3e27e25d64ab@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Am 14.06.19 um 16:14 Uhr schrieb Petr Vorel:
>>> +++ b/testcases/kernel/security/integrity/ima/tests/README.md
>>> @@ -0,0 +1,83 @@
>>> +IMA + EVM testing
>>> +=================
>>> +
>>> +IMA tests
>>> +---------
>>> +
>>> +`ima_measurements.sh` require builtin IMA tcb policy to be loaded
>>> +(`ima_policy=tcb` or `ima_policy=appraise_tcb` kernel parameter).
> 
>> This test requires "appraise_tcb" ("tcb" is not enough), as the errors only
>> occur during appraisal.
> Are you sure? This is a note for ima_measurements.sh test (not for evm_overlay.sh).
> I require ima_policy=tcb here, according to Mimi [1]

Oh, sorry, you are correct - "tcb" is correct in this case. I got 
confused as the documentation is included in the overlayfs reproducer patch.

Ignaz
