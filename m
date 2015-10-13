From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Oct 2015 07:11:41 -0400 (EDT)
Subject: [LTP] [PATCH v2] mem/hugetlb: shift an empty region to use in
 hugemmap02.c
In-Reply-To: <1102055073.29673944.1444733686476.JavaMail.zimbra@redhat.com>
References: <1444647235-3041-1-git-send-email-liwang@redhat.com>
 <20151012182924.GB24472@rei.suse.cz>
 <CAEemH2eZKj6USX5nmVrRQ7QVykOrYZ9c=BhVPASW3=YTatZ0zA@mail.gmail.com>
 <CAEemH2dGJE+zhHH83yeNzAW=A0H8o0T-D3nH=yc1Xt5sN0m2TQ@mail.gmail.com>
 <1102055073.29673944.1444733686476.JavaMail.zimbra@redhat.com>
Message-ID: <445482575.29681653.1444734701609.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Jan Stancek" <jstancek@redhat.com>
> To: "Li Wang" <liwang@redhat.com>, "Cyril Hrubis" <chrubis@suse.cz>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 13 October, 2015 12:54:46 PM
> Subject: Re: [LTP] [PATCH v2] mem/hugetlb: shift an empty region to use in hugemmap02.c

> 
> The approach above should work, but it also stores data to buf,
> that we don't care about. You could do fscanf + "while (fgetc(f) != '\n');"
> to forward to next line, if you want to avoid using buf.

OK, I take that back, Cyril's version is prettier:
> 
>                 ret = fscanf(f, "%lx-%lx %*[^\n]\n", &start, &end);

