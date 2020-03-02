From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 2 Mar 2020 14:37:18 +0530
Subject: [LTP] [PATCH] syscalls/openat2: New tests
In-Reply-To: <20200302084651.GA4736@rei.lan>
References: <b927e5f2cd36ec2dd57202b492563922b1a94e77.1582886993.git.viresh.kumar@linaro.org>
 <20200228132210.GC8324@rei>
 <20200302063714.claovt5uyi7gxf2o@vireshk-i7>
 <20200302084651.GA4736@rei.lan>
Message-ID: <20200302090718.hmyxgbmrwltxiz56@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02-03-20, 09:46, Cyril Hrubis wrote:
> Hmm, I guess that it makes sense to add the pointer to how to the tcase
> structure and allocate exact size for the E2BIG case. That should work
> fine, right?

We need to hack it a bit more to initialize rest of the memory as
well. This is what I did before I dropped the idea.

+static void setup(void)
+{
+       uint *temp;
+
+       openat2_supported_by_kernel();
+
+       temp = (uint *)(how + 1);
+       *temp = 0xDEAD;
+}
+
 static void run(unsigned int n)
 {
        struct tcase *tc = &tcases[n];
@@ -60,10 +70,10 @@ static void run(unsigned int n)
 static struct tst_test test = {
        .tcnt = ARRAY_SIZE(tcases),
        .test = run,
-       .setup = openat2_supported_by_kernel,
+       .setup = setup,
        .needs_tmpdir = 1,
        .bufs = (struct tst_buffers []) {
-               {&how, .size = sizeof(*how)},
+               {&how, .size = 2 * sizeof(*how)},
                {},
        }
 };

-- 
viresh
