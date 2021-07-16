From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Jul 2021 21:21:44 +0800
Subject: [LTP] [PATCH] crypto/af_alg02: use pthread_tryjoin_np() instead
 of pthread_kill()
In-Reply-To: <CAEemH2fdJ_N2PpdCvH8M06U-ov9G0g-tcCdCDV2wZTVWCwCR2g@mail.gmail.com>
References: <20210715102813.106843-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cXAY8KSFNNv8_23uSs-wRaResAkTPmPyZQNN6UwcMcgA@mail.gmail.com>
 <6e1a3663-59ea-5286-5c36-558b077184aa@bell-sw.com>
 <CAEemH2fdJ_N2PpdCvH8M06U-ov9G0g-tcCdCDV2wZTVWCwCR2g@mail.gmail.com>
Message-ID: <CAEemH2c7q8yTC94WvJW61=YtUHBz0_saVM+H=HPysJ0TR-ieVg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>  #define SALSA20_IV_SIZE       8
>>  #define SALSA20_MIN_KEY_SIZE  16
>> +static int completed;
>>
>>  static void *verify_encrypt(void *arg)
>>  {
>>
>
But we still need to initialize '0' at the start of thread_B,
in case of test running with '-i xx' parameter. Isn't it?

     tst_atomic_store(0, &completed);

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210716/96e883bb/attachment.htm>
