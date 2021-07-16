From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Fri, 16 Jul 2021 16:35:08 +0300
Subject: [LTP] [PATCH] crypto/af_alg02: use pthread_tryjoin_np() instead
 of pthread_kill()
In-Reply-To: <CAEemH2c7q8yTC94WvJW61=YtUHBz0_saVM+H=HPysJ0TR-ieVg@mail.gmail.com>
References: <20210715102813.106843-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cXAY8KSFNNv8_23uSs-wRaResAkTPmPyZQNN6UwcMcgA@mail.gmail.com>
 <6e1a3663-59ea-5286-5c36-558b077184aa@bell-sw.com>
 <CAEemH2fdJ_N2PpdCvH8M06U-ov9G0g-tcCdCDV2wZTVWCwCR2g@mail.gmail.com>
 <CAEemH2c7q8yTC94WvJW61=YtUHBz0_saVM+H=HPysJ0TR-ieVg@mail.gmail.com>
Message-ID: <f434cb9f-f8bb-d35c-124d-f469f26d8e6b@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 16.07.2021 16:21, Li Wang wrote:
> 
>         ?#define SALSA20_IV_SIZE? ? ? ?8
>         ?#define SALSA20_MIN_KEY_SIZE? 16
>         +static int completed;
> 
>         ?static void *verify_encrypt(void *arg)
>         ?{
> 
> 
> But we still need to initialize?'0' at the start of thread_B,
> in case of test?running with '-i xx' parameter. Isn't it?
> 
> ? ???tst_atomic_store(0, &completed);
> 

Yeah, right, and that's another reason to use pthread_tryjoin_np() :)

Because otherwise the thread resources not released... anyway we
could add pthread_join in the end of the run()...


> -- 
> Regards,
> Li Wang

