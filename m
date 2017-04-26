From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 26 Apr 2017 03:05:46 -0400 (EDT)
Subject: [LTP] [PATCH v3] syscalls: add new test for copy_file_range(2)
In-Reply-To: <CAEemH2cx63BoV+iTm86WCCXstY8SdQx6fVA0U7Rt3VCDwugF_Q@mail.gmail.com>
References: <20170420082416.25508-1-liwang@redhat.com>
 <917701187.946745.1493024025288.JavaMail.zimbra@redhat.com>
 <CAEemH2fKm5nrMj=ubnE1_D=o5M+1f0deBrstoAjyR9ASN1VLjA@mail.gmail.com>
 <CAEemH2fPXez4K=hY+8hC3jMOfGkqL14PkhKF0VmrtsayzQASQw@mail.gmail.com>
 <a98697fc-9a64-1d4a-7875-d010f0b21ac2@redhat.com>
 <CAEemH2cx63BoV+iTm86WCCXstY8SdQx6fVA0U7Rt3VCDwugF_Q@mail.gmail.com>
Message-ID: <1437131164.2599351.1493190346623.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Mon, Apr 24, 2017 at 02:23:41PM +0200, Jan Stancek wrote:
> > On 04/24/2017 12:46 PM, Li Wang wrote:
> > >>> These variables names are a bit confusing. But larger problem is
> > >
> > > Currently have no idea to improve the confusing issue.
> > >
> >
> > I'm attaching copy_file_range01.c, that I made from your v3 version.
> > It doesn't use static list of parameters, but instead iterates
> > over possible values for len/off_in/off_out in all possible combinations.
> >
> > Let me know what you think about this approach.
> 
> To split data structure into arrays is more clear than before, and involve
> the different function make things simple too. I agree to use this approach.

OK, can this wait after release?

> 
> > static void setup(void)
> > {
> >       int i, fd, page_size;
> >
> >       page_size = getpagesize();
> >
> >       fd = SAFE_OPEN(TEST_FILE_1, O_RDWR | O_CREAT, 0664);
> >       /* Writing page_size * 4 of data into test file */
> >       for (i = 0; i < (int)(page_size * 4); i++)
> >               SAFE_WRITE(1, fd, STR, strlen(STR));
> >       SAFE_CLOSE(fd);
> >
> >       len_sz = 4;
> >       len_arr = malloc(sizeof(size_t) * len_sz);
> >       len_arr[0] = 11;
> > ...
> >       *off_arr[2] = 17;
> 
> These two values(11, 17) are just randomized or have special means here?

Just some random small numbers.

Regards,
Jan
