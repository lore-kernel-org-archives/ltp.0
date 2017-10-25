From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Oct 2017 15:34:39 +0800
Subject: [LTP] [PATCH 1/2] ltp: typos correction
In-Reply-To: <20171025071631.GA4244@rei>
References: <20171025033006.32463-1-liwang@redhat.com>
 <20171025071631.GA4244@rei>
Message-ID: <CAEemH2fg93U1w0KKJujxGjhG1SwVFXn2TdU9RUs8vVYDM1sTTw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 25, 2017 at 3:16 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>>  static struct tst_test test = {
>> -     .tid = "nanosleep()",
>> +     .tid = "clock_nanosleep()",
>>       .sample = sample_fn,
>
> The .tid field should not be set in the tests since a5bf5254ca9
> (tst_test.c: set the test id automatically).

Yes!

I thought if there are some special meaning there before. Because you
put the function
tst_timer_test_setup(tst_test) in the front of get_tid(argv) in tst_test.c.

>
> Just remove it from the test structure here.
>
> I guess that we may as well remove it from the test structure completely
> and keep it hidden in the test library.

Agree!

if so, the code changes in library should be like:

$ git diff
diff --git a/lib/tst_test.c b/lib/tst_test.c
index f8b3fb4..a8a2115 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -688,12 +688,12 @@ static void do_setup(int argc, char *argv[])

        assert_test_fn();

-       if (tst_test->sample)
-               tst_test = tst_timer_test_setup(tst_test);
-
        if (!tst_test->tid)
                tst_test->tid = get_tid(argv);

+       if (tst_test->sample)
+               tst_test = tst_timer_test_setup(tst_test);
+
        parse_opts(argc, argv);

        if (tst_test->needs_root && geteuid() != 0)


If you don't have more suggestion, I will re-write a new patch V2 do that.



-- 
Li Wang
liwang@redhat.com
