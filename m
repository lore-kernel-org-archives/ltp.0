From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Apr 2020 20:03:45 +0800
Subject: [LTP] Add new test for pipe2 with/without O_NONBLOCK mode
In-Reply-To: <c4118b86-b364-1355-3bf4-602a9ae0c5bc@cn.fujitsu.com>
References: <20200409211255.1357-1-laniel_francis@privacyrequired.com>
 <7c9e27de-aaff-98ea-4e00-2c242f7a0cc3@cn.fujitsu.com>
 <f8f3aea3-5371-a8b5-09dd-1200d9dc6d72@cn.fujitsu.com>
 <CAEemH2dzt4Hi7HDyO4Spn_i3naJbhQ5GwpZVCk3BgkdaL5uNWg@mail.gmail.com>
 <c4118b86-b364-1355-3bf4-602a9ae0c5bc@cn.fujitsu.com>
Message-ID: <CAEemH2d59S0StA6q-r2w4xYrdqDpHxu9zqzJH5uiEk4H4eeVJw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu, Laniel,

Patchset changed as the following and pushed:

  * [1/2] move safe_pipe2() to tst_safe_macro.c
  * [1/2] remove cleanup_fn callback from function
  * [1/2] replace tst_brk() by tst_brk_()
  * [1/2] add flag in the print message
  * [2/2] rename to pipe2_04.c
  * [2/2] remove useless status variable
  * [2/2] code indent cleanup

@Laniel, remember to use '-s' in the git-commit command next time, then it
will help add the Signed-off-by: automatically.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200417/19996939/attachment-0001.htm>
