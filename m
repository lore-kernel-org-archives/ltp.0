From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 3 Feb 2021 08:48:57 +0100
Subject: [LTP] [PATCH 2/2] mq_timedreceive_5-3: Fix test for timestamp
 after INT32_MAX
In-Reply-To: <20210203074520.18401-2-lkml@jv-coder.de>
References: <20210203074520.18401-1-lkml@jv-coder.de>
 <20210203074520.18401-2-lkml@jv-coder.de>
Message-ID: <54607759-e48f-0a45-fab8-5d07ec32f004@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Just FYI:

On 2/3/2021 8:45 AM, Joerg Vehlow wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
>
> The timeout for mq_timedreceive is absolute. Using INT32_MAX
> breaks this test after 2038-01-19.
Funny thing is, that the other bug fixed in the first patch hid this bug.
mq_timedreceive returned with ETIMEDOUT immediately, but wait blocked,
until it was interrupted by the signal -> erno was EINTR and the test 
passed.

J?rg
