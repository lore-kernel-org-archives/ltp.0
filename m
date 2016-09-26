From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Sep 2016 10:25:01 +0200
Subject: [LTP] [PATCH v3] runltp: add -R option for randomize test order
In-Reply-To: <20160925134701.GD12847@dhcp12-143.nay.redhat.com>
References: <1474720519-12067-1-git-send-email-zlang@redhat.com>
 <CAEemH2foVLCW=XTmR9a8qmAJQvjw8ZEsOrrAAmUPSCX45ob=Fw@mail.gmail.com>
 <20160925134701.GD12847@dhcp12-143.nay.redhat.com>
Message-ID: <20160926082501.GA32494@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Hm, it works, even works for large file (>pagesize). I thought it maybe make
> mistake if read and rewrite same file at same time when I sent this patch.
> Now I just read the code of sort.c, it'll read the file into buffer and temp
> file at first, then close the fopen(r) file and go to fopen(w) the file:
> 
>           if (buf.eof && !nfiles && !ntemps && !buf.left)
>             {
>               xfclose (fp, file);
>               tfp = xfopen (output_file, "w");
> 	      ...
> 	      ...
> 
> So it looks safe to read and write the same file together ... But I don't know
> if it worth changing this patch (the old way looks safer:). Can maintainers
> choose a favorite way?

The POSIX specification for sort explicitly states:

-o  output
    Specify the name of an output file to be used instead of the
    standard output. This file can be the same as one of the input
    files.

So I would say that using the same filename for input and output is
pretty much safe.

-- 
Cyril Hrubis
chrubis@suse.cz
