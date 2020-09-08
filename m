From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 8 Sep 2020 17:36:59 +0200
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
References: <20200908073138.GB2475@yuki.lan>
 <CAEemH2cHvM_KD7W6fyX6z3bc0qfVtkp=yEM8MDvvohouyj5N2w@mail.gmail.com>
Message-ID: <20200908153659.GA16066@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> And I'd like to add the MAP_GROWSDOWN test too, but I haven't come up with
> a way to solve the segment fault on s390x.
> http://lists.linux.it/pipermail/ltp/2020-August/018416.html

Maybe we end up allocating a mapping that is too close to something
else, see:

https://stackoverflow.com/questions/56888725/why-is-map-growsdown-mapping-does-not-grow

I guess that we should make the initial mmap in find_free_range() larger
and return and adress that is quaranteed not to have a mapping that is
closer than 256 pages in the direction we want to grow.

-- 
Cyril Hrubis
chrubis@suse.cz
