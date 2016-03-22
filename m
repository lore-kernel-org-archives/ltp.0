From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Mar 2016 22:01:42 +0800
Subject: [LTP] [PATCH 2/4] mm/ksm: extend 'max_page_sharing' before ksm
	testing
In-Reply-To: <CAEemH2ewrJmmYOuEcR8QfKsVgyi7aGpwAp8POWnzoORB8BMr-Q@mail.gmail.com>
References: <1457602468-24268-1-git-send-email-liwang@redhat.com>
 <1457602468-24268-2-git-send-email-liwang@redhat.com>
 <20160322131422.GA10905@rei.suse.cz>
 <CAEemH2ewrJmmYOuEcR8QfKsVgyi7aGpwAp8POWnzoORB8BMr-Q@mail.gmail.com>
Message-ID: <CAEemH2dOqgg_90dwoy2NZBXqzGFq8cGtDufJGP10VaAaAZF7SA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 22, 2016 at 9:42 PM, Li Wang <liwang@redhat.com> wrote:

> Hi Cyril,
>
> On Tue, Mar 22, 2016 at 9:14 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> > diff --git a/testcases/kernel/mem/include/mem.h
>> b/testcases/kernel/mem/include/mem.h
>> > index 43988fe..fbb11b2 100644
>> > --- a/testcases/kernel/mem/include/mem.h
>> > +++ b/testcases/kernel/mem/include/mem.h
>> > @@ -43,6 +43,7 @@ void testoom(int mempolicy, int lite, int retcode,
>> int allow_sigkill);
>> >  /* KSM */
>> >
>> >  #define PATH_KSM             "/sys/kernel/mm/ksm/"
>> > +int max_page_sharing;
>>
>> This variable is not used in the library. It does not make sense to
>> declare it in the header file.
>>
>
> no, it has been used in mem.c file.
>

Oops! you are right, I didn't noticed that it just a string(not the value)
in the mem.c codes. sorry for making noise here. I will re-write the
patches.


>
> see here:
> ------------
> diff --git a/testcases/kernel/mem/lib/
> mem.c b/testcases/kernel/mem/lib/mem.c
> index 7b5bb35..d37d6a4 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -502,9 +502,12 @@ void create_same_memory(int size, int num, int unit)
>         stop_ksm_children(child, num);
>
>         tst_resm(TINFO, "KSM merging...");
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +               SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
> +                               "%ld", size * pages * num);
>         SAFE_FILE_PRINTF(cleanup, PATH_KSM "run", "1");
>         SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
> -                        size * pages *num);
> +                        size * pages * num);
>         SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
>
>         resume_ksm_children(child, num);
> @@ -595,6 +598,9 @@ void test_ksm_merge_across_nodes(unsigned long
> nr_pages)
>         SAFE_FILE_PRINTF(cleanup, PATH_KSM "sleep_millisecs", "0");
>         SAFE_FILE_PRINTF(cleanup, PATH_KSM "pages_to_scan", "%ld",
>                          nr_pages * num_nodes);
> +       if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
> +               SAFE_FILE_PRINTF(cleanup, PATH_KSM "max_page_sharing",
> +                       "%ld", nr_pages * num_nodes);
>
>
>
>> >  void test_ksm_merge_across_nodes(unsigned long nr_pages);
>> >
>> > diff --git a/testcases/kernel/mem/ksm/ksm01.c
>> b/testcases/kernel/mem/ksm/ksm01.c
>> > index b62df06..a352abd 100644
>> > --- a/testcases/kernel/mem/ksm/ksm01.c
>> > +++ b/testcases/kernel/mem/ksm/ksm01.c
>> > @@ -105,6 +105,9 @@ void setup(void)
>> >               tst_brkm(TCONF, NULL, "2.6.32 or greater kernel
>> required");
>> >       if (access(PATH_KSM, F_OK) == -1)
>> >               tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
>> > +     if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
>> > +             SAFE_FILE_SCANF(NULL, PATH_KSM "max_page_sharing",
>> > +                             "%d", &max_page_sharing);
>> >
>> >       /*
>> >        * kernel commit 90bd6fd introduced a new KSM sysfs knob
>> > @@ -128,4 +131,8 @@ void cleanup(void)
>> >       if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
>> >               FILE_PRINTF(PATH_KSM "merge_across_nodes",
>> >                                "%d", merge_across_nodes);
>> > +
>> > +     if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
>> > +             FILE_PRINTF(PATH_KSM "max_page_sharing",
>> > +                              "%d", max_page_sharing);
>> >  }
>>
>> You are saving and restoring the file in each test. Why can't you just
>> add two functions to save and restore it the library instead and call
>> them from test setup and cleanup?
>>
>
> ok, that's a better way.
>
>
>>
>> It's also quite confusing that the test saves and restores a value while
>> it's not modifying it at all. It will be less confusing if it's all done
>> in the library.
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>>
>
>
>
> --
> Regards,
> Li Wang
> Email: liwang@redhat.com
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160322/f174172d/attachment-0001.html>
