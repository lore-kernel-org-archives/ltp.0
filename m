From: Li Wang <liwan@redhat.com>
Date: Sat, 1 Dec 2018 17:57:41 +0800
Subject: [LTP] [PATCH] fzsync: limit sampling time
In-Reply-To: <45587008.81059248.1543654685122.JavaMail.zimbra@redhat.com>
References: <c49a5628139703513cb66d84d03953ddb5cc1560.1543489660.git.jstancek@redhat.com>
 <CAEemH2cVjYJLwLvkvS3QK7PwmM=g+HzFFaPo5YK3uAex3SEghA@mail.gmail.com>
 <45587008.81059248.1543654685122.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2c0ZFO1xOy00QEuAsrx8JPS7_00DwHqGHKaHfGVN-VW=A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Oops, I click send button before input anything in last email. Sorry about that.

On Sat, Dec 1, 2018 at 4:58 PM Jan Stancek <jstancek@redhat.com> wrote:
> Wouldn't we spend too much time sampling on fast systems
> without much gain?

Well, seems there is no need to do much sampling on faster system.

>
> My impression was we want to get out of sampling phase ASAP,
> so library can start inserting random delays.

Ok, after thinking over, to drop min_samples maybe doesn't make much
sense for library. Now I'd keep the patch as the V2.

-- 
Regards,
Li Wang
