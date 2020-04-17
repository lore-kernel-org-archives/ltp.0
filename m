From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Apr 2020 15:42:16 +0800
Subject: [LTP] Add new test for pipe2 with/without O_NONBLOCK mode
In-Reply-To: <f8f3aea3-5371-a8b5-09dd-1200d9dc6d72@cn.fujitsu.com>
References: <20200409211255.1357-1-laniel_francis@privacyrequired.com>
 <7c9e27de-aaff-98ea-4e00-2c242f7a0cc3@cn.fujitsu.com>
 <f8f3aea3-5371-a8b5-09dd-1200d9dc6d72@cn.fujitsu.com>
Message-ID: <CAEemH2dzt4Hi7HDyO4Spn_i3naJbhQ5GwpZVCk3BgkdaL5uNWg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Thanks for reviewing the patches.

Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> ...
> > I modify your patch and merged into my ltp own fork.
> > see
> >
> https://github.com/xuyang0410/ltp/commits/Laniel_francis_pipe2_03_v3.fixes
> >
> > ps: I will convert pipe2_01/02.c into new libray and use SAFE_PIPE2
> macro.
> Can you merge the safe_pipe2 patch(don't need to add this macro into old
> safe_macro header) into master? so then I can write new test cases
>

I'm ok with only support it in the new library.

But if we export the safe macro only to use by new API, we'd better add it
into lib/tst_safe_macros.c
but not lib/safe_macros.c, this patch leaves the 'void (*cleanup_fn)
(void)' hook in function safe_pipe2()
and put in safe_macros.c that is compatible with both API using.

Do you think so? if yes I can help to move it to tst_safe_macros.c and
apply it.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200417/1982f0dc/attachment-0001.htm>
