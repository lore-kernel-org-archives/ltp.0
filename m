From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Sep 2016 09:56:47 -0400 (EDT)
Subject: [LTP] [v2] readahead02: fix read_ahead_kb file not found
In-Reply-To: <1526367732.41107.1473171720947.JavaMail.zimbra@redhat.com>
References: <1472812953-30811-1-git-send-email-naresh.kamboju@linaro.org>
 <747949240.1570236.1473060993124.JavaMail.zimbra@redhat.com>
 <CA+G9fYvFO3yVs1j89jCD=WxQBSUH-ZZL-Go-Yjvd5-P8Vpzn9Q@mail.gmail.com>
 <1526367732.41107.1473171720947.JavaMail.zimbra@redhat.com>
Message-ID: <1603573767.285723.1473775007201.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Naresh Kamboju" <naresh.kamboju@linaro.org>
> Cc: "graeme gregory" <graeme.gregory@linaro.org>, "milosz wasilewski" <milosz.wasilewski@linaro.org>,
> akpm@linux-foundation.org, "fengguang wu" <fengguang.wu@intel.com>, ltp@lists.linux.it
> Sent: Tuesday, 6 September, 2016 4:22:00 PM
> Subject: Re: [LTP] [v2] readahead02: fix read_ahead_kb file not found
> 
> 
> 
> 
> 
> ----- Original Message -----
> > From: "Naresh Kamboju" <naresh.kamboju@linaro.org>
> > To: "Jan Stancek" <jstancek@redhat.com>
> > Cc: "chrubis" <chrubis@suse.cz>, ltp@lists.linux.it,
> > akpm@linux-foundation.org, "fengguang wu"
> > <fengguang.wu@intel.com>, "graeme gregory" <graeme.gregory@linaro.org>,
> > "milosz wasilewski"
> > <milosz.wasilewski@linaro.org>
> > Sent: Tuesday, 6 September, 2016 2:33:58 PM
> > Subject: Re: [LTP] [v2] readahead02: fix read_ahead_kb file not found
> > 
> > Hi Jan,
> > 
> > On 5 September 2016 at 13:06, Jan Stancek <jstancek@redhat.com> wrote:
> > >
> > >
> > > ----- Original Message -----
> > >> From: "naresh kamboju" <naresh.kamboju@linaro.org>
> > >> To: chrubis@suse.cz, ltp@lists.linux.it
> > >> Cc: akpm@linux-foundation.org, "fengguang wu" <fengguang.wu@intel.com>,
> > >> "graeme gregory" <graeme.gregory@linaro.org>,
> > >> "milosz wasilewski" <milosz.wasilewski@linaro.org>
> > >> Sent: Friday, 2 September, 2016 12:42:33 PM
> > >> Subject: [LTP] [v2] readahead02: fix read_ahead_kb file not found
> > >>
> > >> From: Naresh Kamboju <naresh.kamboju@linaro.org>
> > >>
> > >> Test case is looking for read_ahead_kb file on a partition device (8:2)
> > >> and
> > >> not on block device (8:0/8:16/8:32/8:48). The appropriate block device
> > >> that
> > >> holds the partition can be found at queue/read_ahead_kb entry.

Just fyi, there is a patch proposed to change this limit again:
  https://lkml.org/lkml/2016/7/25/308

Regards,
Jan
