From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Mar 2020 21:07:32 +0800
Subject: [LTP] [PATCH v2 4/5] lib: Implement SAFE_CMD() macro (new API
 only)
In-Reply-To: <CAEemH2dcxrpB_dkp26=5oiMdY_2OVw5v_OjpyG37N+zx7y+A9g@mail.gmail.com>
References: <20200330124338.6764-1-pvorel@suse.cz>
 <20200330124338.6764-5-pvorel@suse.cz>
 <CAEemH2dcxrpB_dkp26=5oiMdY_2OVw5v_OjpyG37N+zx7y+A9g@mail.gmail.com>
Message-ID: <CAEemH2dKmth7qCxsnnAxhiJVqE-A22zRYzNm9rEzTw3etY_+8g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 30, 2020 at 9:01 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Mon, Mar 30, 2020 at 8:43 PM Petr Vorel <pvorel@suse.cz> wrote:
>
>> Reviewed-by: Li Wang <liwang@redhat.com>
>> Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>>  doc/test-writing-guidelines.txt |  3 +++
>>  include/tst_safe_macros.h       | 18 ++++++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/doc/test-writing-guidelines.txt
>> b/doc/test-writing-guidelines.txt
>> index 7069d3c8f..6f1eee490 100644
>> --- a/doc/test-writing-guidelines.txt
>> +++ b/doc/test-writing-guidelines.txt
>> @@ -1283,6 +1283,9 @@ return value is '255' if 'execvp()' failed with
>> 'ENOENT' and '254' otherwise.
>>  'stdout_path' and 'stderr_path' determine where to redirect the program
>>  stdout and stderr I/O streams.
>>
>> +The 'SAFE_CMD()' macro can be used automatic handling non zero exits
>> (exits
>> +with 'TBROK') or 'ENOENT' (exits with 'TCONF').
>> +
>>  .Example
>>  [source,c]
>>
>>  -------------------------------------------------------------------------------
>> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
>> index d95d26219..38eb67d1d 100644
>> --- a/include/tst_safe_macros.h
>> +++ b/include/tst_safe_macros.h
>> @@ -21,6 +21,7 @@
>>  #include <grp.h>
>>
>>  #include "safe_macros_fn.h"
>> +#include "tst_cmd.h"
>>
>>  #define SAFE_BASENAME(path) \
>>         safe_basename(__FILE__, __LINE__, NULL, (path))
>> @@ -534,4 +535,21 @@ int safe_personality(const char *filename, unsigned
>> int lineno,
>>  void safe_unshare(const char *file, const int lineno, int flags);
>>  #define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
>>
>> +void safe_cmd(const char *file, const int lineno, const char *const
>> argv[],
>> +                                 const char *stdout_path, const char
>> *stderr_path)
>> +{
>> +       int rval;
>> +
>> +       switch ((rval = tst_run_cmd(argv, stdout_path, stderr_path,
>>
>
tst_cmd ^

> +                                   TST_RUN_CMD_PASS_EXIT_VAL |
>> +                                   TST_RUN_CMD_CHECK_CMD))) {
>>
>
> This should be TST_CMD_TCONF_ON_MISSING ^.
>
> I'd help to build&run the whole patches tomorrow, anything wrong if I can
> find will reply to you then.
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200330/b7d3f24f/attachment-0001.htm>
