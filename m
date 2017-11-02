From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Nov 2017 10:21:13 +0800
Subject: [LTP] [PATCH v3 1/2] ltp: fix some frequent typoes
In-Reply-To: <20171101134356.GA10818@rei.lan>
References: <20171101051523.373-1-liwang@redhat.com>
 <20171101134356.GA10818@rei.lan>
Message-ID: <CAEemH2eEGxZnmPEwSQ5buV=5RTaRuj2qUhDb1m9JGBi7+qYvhg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 1, 2017 at 9:43 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
>> index 9562005..ed9c73c 100644
>> --- a/include/tst_safe_macros.h
>> +++ b/include/tst_safe_macros.h
>> @@ -406,7 +406,7 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
>>  #define SAFE_EXECL(file, arg, ...) do {                              \
>>         execl((file), (arg), ##__VA_ARGS__);                  \
>>         tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,          \
>> -                "execlp(%s, %s, ...) failed", file, arg);    \
>> +                "execl(%s, %s, ...) failed", file, arg);     \
>>         } while (0)
>
> Can you, pretty please, put this change into a separate patch?

Of course I can. But this is still a typo which was involved by:

commit 3a4772603733e5be11b367e156723aa554c4a1fc
Author: Li Wang <liwang@redhat.com>
Date:   Thu Oct 12 11:27:59 2017 +0200

    creat07: switch EXECLP to EXECL


>
> Since the rest of the changes are just fixing typos, there is no change
> in behaivor. But this one actually changes it and there is even no
> description for it in the commit message.

Sorry, I feel a little confused.

This typo only in the printed messages but without any behavior changing too.
The situation is that if execl() get failed and then tst_brk do exist
with the typo print.

Anyway, if you insist that I could write a new patch for it. :)

-- 
Li Wang
liwang@redhat.com
