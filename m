From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 1 Apr 2016 10:45:55 -0400 (EDT)
Subject: [LTP] Test library API changes
In-Reply-To: <20160331100146.GA20485@rei.lan>
References: <20160105111136.GA32659@rei.lan> <20160314125153.GB600@rei.lan>
 <20160314160036.GA2511@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
 <20160315092226.GA26279@rei.lan> <20160317160606.GA31815@rei.lan>
 <457777222.10886512.1458294282223.JavaMail.zimbra@redhat.com>
 <20160331100146.GA20485@rei.lan>
Message-ID: <1766074746.16671841.1459521955321.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 31 March, 2016 12:01:46 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> Latest version is at usuall place:
> 
> https://github.com/metan-ucw/ltp
> 
> Now rest of the library calls should be wired to the new library as
> well, see for example this header:
> 
> https://github.com/metan-ucw/ltp/blob/master/include/tst_fs.h

Isn't it the other way around? Newlib interface wired to old lib implementation?
Do the names with "_" at the end have any special meaning?

Was "#ifdef TST_TEST_H__" used in previous versions? Is there a difference
between ifdef approach and splitting interface to old_* header?

> 
> The documentation was updated as well (I've even added a few functions
> that were not documented previously).

"resource_files" still appears to be undocumented.

> 
> I've also compared build logs to make sure that the changes haven't
> introduced new warnings and did a few syscall testruns to make sure
> everything works fine. Both looks good to me.
> 
> We are not that far from next LTP release. As a matter of fact we should
> start preparing for it anytime soon. Ideally I would like to get this
> merged before the release freeze and testing. What do you think?

I think technically it's going to work fine. My only worry is
how much are old/new API mixed together when I'm looking at
ltp/include directory. And I keep thinking: "As someone editing
testcase that is using old/new API, what headers should/shouldn't
I use?"

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
