From: $rik@nth  <srikanth007m@gmail.com>
Date: Fri, 9 Oct 2015 08:28:42 +0530
Subject: [LTP] inotify06 test causing kernel panic
In-Reply-To: <20151008202533.GA11505@rei.suse.cz>
References: <CANKSX+G1QKMqRF8TzSxGQAe=i+VQFAqmL8qpBTdaup1pSzivww@mail.gmail.com>
 <20151008202533.GA11505@rei.suse.cz>
Message-ID: <CANKSX+EBfkoZKCBOZdEhT6+Ba2PR5xFCc2iCnAe4jVd6amffqw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Yes. Later i saw the source and noticed.


On Fri, Oct 9, 2015 at 1:55 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> on latest available LTP release there is one newly added test
>> `inotify06 `. Which is causing kernel panic. Is the test targeted to
>> >4.0 kernel? Can anyone confirm.
>
> If you look at the test source it clearly says that it's regression test
> for a bug in inotify that has been fixed in kernel 4.2 and that older
> kernels are buggy and will likely panic.
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Thanks & Regards,
M.Srikanth Kumar.
