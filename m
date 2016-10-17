From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Oct 2016 16:30:43 +0200
Subject: [LTP] MD-RAID: Use seq_putc() in three status functions?
In-Reply-To: <57299b72-8e6b-0b92-4374-1b7a0907e810@suse.de>
References: <566ABCD9.1060404@users.sourceforge.net>
 <786843ef-4b6f-eb04-7326-2f6f5b408826@users.sourceforge.net>
 <92c52f1d-d151-cea6-e9ac-31378e6862d0@users.sourceforge.net>
 <1475771699.1914.10.camel@perches.com>
 <77fb6fdc-7480-8607-0af1-42f73c125b9d@users.sourceforge.net>
 <688764a4-072d-2faf-37ba-a222b190a5d9@suse.de>
 <59d71170-c48d-a084-c748-b6ab74a2bee4@users.sourceforge.net>
 <1e151094-e228-5307-ae2f-b376b31f5628@suse.de>
 <83e720c6-9037-a3c1-6e83-27505805f37f@users.sourceforge.net>
 <2cc42b2f-1f1a-e95c-91fa-54e1dd3b6d49@suse.de>
 <653e60ee-f862-8828-3e4f-498c7cc34bdc@users.sourceforge.net>
 <c2500336-5848-66c3-ecf0-1ade04decf75@suse.de>
 <a0f96e19-fa24-8507-2b77-344a342113aa@users.sourceforge.net>
 <1476703920.2520.105.camel@petrovitsch.priv.at>
 <97f31b70-e3ff-f194-c753-54da1fe3e664@users.sourceforge.net>
 <57299b72-8e6b-0b92-4374-1b7a0907e810@suse.de>
Message-ID: <cb9beadc-3ea2-c09c-f621-a54cd73e3647@users.sourceforge.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>> Am I the only software developer so far who would dare to reconsider
>> implementation details from three status functions?
>>
> No.

Thanks for this kind of promising feedback.


> But we're waiting for you showing is that it is an improvement.

Can this aspect also be clarified to some degree from a logical point of view?

* Would you really like to know under which circumstances data processing
  will be faster for a single character instead of using a string pointer
  and corresponding two characters?

* Do you care for a changed memory allocation characteristic?

* Will it occasionally be useful to avoid the storage for another string literal?

Regards,
Markus
