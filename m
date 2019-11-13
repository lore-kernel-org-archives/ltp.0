From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 13 Nov 2019 10:34:55 +0100
Subject: [LTP] [PATCH 1/2] Wrapper for Syzkaller reproducers
In-Reply-To: <CAEemH2e_8_DZrhA6wSxy68vjv+F+q9fyeHq3RK=3WXC=j+teYg@mail.gmail.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-2-rpalethorpe@suse.com>
 <CACT4Y+aYVH=e+ZJhF2b-b92dkJZwjnPP4keup509twcQqK+wMg@mail.gmail.com>
 <CAEemH2eVR4U8dHR6anmirX_X5Y3hXKgL4cHxekeVXH_wSHnnpA@mail.gmail.com>
 <87ftitdwjq.fsf@rpws.prws.suse.cz>
 <CAEemH2eAnkr-n+DxtioUY1M3nbLN8sORWO2k2LBgacPTgGMKhA@mail.gmail.com>
 <CAEemH2e_8_DZrhA6wSxy68vjv+F+q9fyeHq3RK=3WXC=j+teYg@mail.gmail.com>
Message-ID: <87eeycdsqo.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> On Tue, Nov 12, 2019 at 10:10 PM Li Wang <liwang@redhat.com> wrote:
>
>>
>>
>> On Tue, Nov 12, 2019 at 10:00 PM Richard Palethorpe <rpalethorpe@suse.de>
>> wrote:
>>
>>> Hello,
>>>
>>> Li Wang <liwang@redhat.com> writes:
>>>
>>> >
>>> >
>>> > Just to try build it in LTP and hit errors:
>>> >
>>> > # cd ltp-new/
>>> > # make autotools
>>> > # ./configure --with-syzkaller-repros
>>> > # make -j32
>>> > ...
>>> > error: pathspec '/root/ltp-new/testcases/linux-arts' did not match any
>>> > file(s) known to git
>>> > make[3]: ***
>>> [/root/ltp-new/testcases/kernel/syzkaller-repros/Makefile:26:
>>> > /root/ltp-new/testcases/linux-arts/syzkaller-repros/linux] Error 1
>>> > make[3]: Leaving directory
>>> '/root/ltp-new/testcases/kernel/syzkaller-repros'
>>> > make[2]: *** [../../include/mk/generic_trunk_target.inc:93: all] Error 2
>>> > make[2]: Leaving directory '/root/ltp-new/testcases/kernel'
>>> > make[1]: *** [../include/mk/generic_trunk_target.inc:93: all] Error 2
>>> > make[1]: Leaving directory '/root/ltp-new/testcases'
>>> > make: *** [Makefile:108: testcases-all] Error 2
>>> >
>>> >
>>>
>>> What happens if you try to pull the git submodule manually?
>>>
>> # pwd
>> /root/ltp-new
>>
>> # git submodule update --init testcases/linux-arts
>> error: pathspec 'testcases/linux-arts' did not match any file(s) known to
>> git
>>
>>
>>>
>>> i.e. do git submodule update --init testcases/linux-arts
>>>
>>> It looks like it failed on the line where it gets the submodule, so I am
>>> wondering if you have an old git version?
>>
>>
>> Not sure if that related to git-version, I'm trying to look into it.
>>
>
> I have tried many times with different systems but still not working.
>
> My question is did you add the submodule via 'git-submodule add' commands?
> or just modify the .gitmodules file by hand?
>
> i.e: `git submodule add
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-arts.git
> testcases/linux-arts`
>
> I don't understand why I can't see the subproject commit-id in your patch.
> I have to perform git-submodule-add locally again then it could compile for
> me.
>
> i.e:
> diff --git a/testcases/linux-arts b/testcases/linux-arts
> new file mode 160000
> index 0000000..07759b8
> --- /dev/null
> +++ b/testcases/linux-arts
> @@ -0,0 +1 @@
> +Subproject commit 07759b820a9cbf01333d861d8eb2613b20d1ede4
>
> Or did I missing anything?

Sorry, I think it is probably my fault. I added the submodule properly,
but I set 'ignore = all' to .gitmodules which prevents the commit-id
from being added to the patchset.

I set ignore=all because I thought it would probably be best to always
get the HEAD of linux-arts, at least to begin with. Otherwise we have to
remember to update it.

--
Thank you,
Richard.
