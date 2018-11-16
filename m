From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Nov 2018 16:02:45 +0100
Subject: [LTP] [Automated-testing] [RFC] [PATCH] lib: Add support for
 test tags
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF88A3CC04@USCULXMSG01.am.sony.com>
References: <20181107142209.8965-1-chrubis@suse.cz>
 <156962223.71358453.1541698207250.JavaMail.zimbra@redhat.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A346A7@USCULXMSG01.am.sony.com>
 <20181109102859.GA19700@rei.lan>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A3CC04@USCULXMSG01.am.sony.com>
Message-ID: <20181116150245.GB13883@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > I'd like to see a way to extract this data without having to
> > > run the test as well.  That way test frameworks using LTP
> > > could extract the data and handle test scheduling,
> > > test dependencies, etc. without having to build or execute
> > > the code.  In the case of Fuego, test dependencies are analyzed
> > > on a separate machine from the one running the test.  Also,
> > > we try to process some dependencies prior to building the test.
> > 
> > What I had in mind was some additional database build step where
> > all tests would be executed with -q parameter on the target machine
> > which would create a big structured file with all the metadata. So first
> > thing before any test would be executed would be a script that would
> > check if there is a database file or not and and if there is none it
> > would build it, then we can get the database from the target machine
> > and the test runner can make use of that.
> > 
> > This process has to be either part of the LTP build or has to be
> > executed before first testrun anyways, sice there is no other way
> > to keep the data in sync with the binaries.
> 
> OK - I think we could make that work in Fuego.
> 
> Is any of the information you are encoding architecture-specific?

As it is test are disabled on missing library headers on compile time
and in rare case based on architecture. In that case the tst_test
structure is ifdefed out and the test library only gets a dummy one
which means that there will be no data. I guess that I will have to look
into that.

> It might be convenient for Fuego to build LTP on x86_64 to extract
> this data, and then build the actual test binaries for the target architecture
> in a separate step.  But that wouldn't work if the x86_64
> binaries gave different '-q' results than the (say) ARM binaries.

Agreed, the cross compilation would become much more complex if we
required to run target binaries.

> > > One mechanism for storing the data would be a separate json
> > > file, but you could also embed the information in the source
> > > using some regularized markup (json or something simpler)
> > > that could be handled both in-source (for your -q operation),
> > > or by an external scanner/converter.
> > 
> > Actually I've started to think that this may be the answer, if we manage
> > to encode the metadata into C string as well as into some structured
> > form we can have test description as well as some of the metadata
> > available both at the runtime as well as in a format that could be
> > parsed without compiling the test.
> > 
> > But there are drawbacks, I do not think that it's sane to encode if test
> > requires root or not, or if it needs a block device in some kind of
> > markup text. I think that it's mutch better when it's encoded in the
> > tst_test structure as it is now.
> If there's a standard way of expressing this that can be reliably grepp'ed,
> I don't think everything needs to be in a structured form.
> As long as it's not too difficult to write a parser, and there are
> some conventions that naturally keep the data parsable, I think having
> the metadata in C strings is fine.
> 
> For example, "grep needs_root -R * | grep -v Binary" shows a list which
> is pretty clear.   Maybe it's missing some instances, due to a program setting
> setting this field in a weird way,  but I kind of doubt it.
> (This field is usually declared statically like this, right?
> It would be harder to parse if needs_root is assigned at runtime.)

In the new library it's all static data passed in the test library. The
old LTP API was a mess of random functions, so at some point I've
decided to rewrite it so that we specify most of the test information in
a form of a constant data. However so far we managed to covert about 30%
of tests to the new API and converting the rest will take a few more
years...

-- 
Cyril Hrubis
chrubis@suse.cz
